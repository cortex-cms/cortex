require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Snippets < Grape::API
        helpers Helpers::SharedParams

        resource :snippets do
          helpers Helpers::PaginationHelper
          helpers Helpers::SnippetsHelper

          desc 'Show all snippets', { entity: Entities::Snippet, nickname: 'showAllSnippet' }
          params do
            use :pagination
          end
          oauth2 'view:snippets'
          get do
            authorize! :view, ::Snippet

            @snippet = ::Snippet.order(created_at: :desc).page(page).per(per_page)
            set_pagination_headers(@snippet, 'snippet')
            present @snippet, with: Entities::Snippet
          end

          desc 'Get snippet', { entity: Entities::Snippet, nickname: 'showSnippet' }
          oauth2 'view:snippets'
          get ':id' do
            authorize! :view, snippet!

            present snippet, with: Entities::Snippet
          end

          desc 'Create snippet', { entity: Entities::Snippet, params: Entities::Snippet.documentation, nickname: 'createSnippet' }
          oauth2 'modify:snippets'
          post do
            authorize! :create, ::Snippet

            snippet_params = params[:snippet] || params

            @snippet = ::Snippet.new(declared(snippet_params, { include_missing: false }, Entities::Snippet.documentation.keys))
            snippet.user = current_user!
            snippet.save!

            present snippet, with: Entities::Snippet
          end

          desc 'Update snippet', { entity: Entities::Snippet, params: Entities::Snippet.documentation, nickname: 'updateSnippet' }
          oauth2 'modify:snippets'
          put ':id' do
            authorize! :update, snippet!

            snippet_params = params[:snippet] || params

            snippet.update!(declared(snippet_params, { include_missing: false }, Entities::Snippet.documentation.keys))

            present snippet, with: Entities::Snippet
          end

          desc 'Delete snippet', { nickname: 'deleteSnippet' }
          oauth2 'modify:snippets'
          delete ':id' do
            authorize! :delete, snippet!

            begin
              snippet.destroy
            rescue Cortex::Exceptions::ResourceConsumed => e
              error = error!({
                               error:   'Conflict',
                               message: e.message,
                               status:  409
                             }, 409)
              error
            end
          end
        end
      end
    end
  end
end
