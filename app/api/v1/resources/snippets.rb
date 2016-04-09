module V1
  module Resources
    class Snippets < Grape::API
      resource :snippets do
        include Grape::Kaminari
        helpers ::V1::Helpers::SnippetsHelper

        paginate per_page: 25

        desc 'Show all snippets', { entity: ::V1::Entities::Snippet, nickname: 'showAllSnippet' }
        get do
          authorize! :view, ::Snippet
          require_scope! 'view:snippets'

          @snippet = ::Snippet.order(created_at: :desc)
          ::V1::Entities::Snippet.represent paginate(@snippet)
        end

        desc 'Get snippet', { entity: ::V1::Entities::Snippet, nickname: 'showSnippet' }
        get ':id' do
          require_scope! 'view:snippets'
          authorize! :view, snippet!

          present snippet, with: ::V1::Entities::Snippet
        end

        desc 'Create snippet', { entity: ::V1::Entities::Snippet, params: ::V1::Entities::Snippet.documentation, nickname: 'createSnippet' }
        post do
          require_scope! 'modify:snippets'
          authorize! :create, ::Snippet

          snippet_params = params[:snippet] || params

          @snippet = ::Snippet.new(declared(snippet_params, { include_missing: false }, ::V1::Entities::Snippet.documentation.keys))
          snippet.user = current_user!
          snippet.save!

          present snippet, with: ::V1::Entities::Snippet
        end

        desc 'Update snippet', { entity: ::V1::Entities::Snippet, params: ::V1::Entities::Snippet.documentation, nickname: 'updateSnippet' }
        put ':id' do
          require_scope! 'modify:snippets'
          authorize! :update, snippet!

          snippet_params = params[:snippet] || params

          snippet.update!(declared(snippet_params, { include_missing: false }, ::V1::Entities::Snippet.documentation.keys))

          present snippet, with: ::V1::Entities::Snippet
        end

        desc 'Delete snippet', { nickname: 'deleteSnippet' }
        delete ':id' do
          require_scope! 'modify:snippets'
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
