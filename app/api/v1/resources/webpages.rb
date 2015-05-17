require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Webpages < Grape::API
        helpers Helpers::SharedParams

        resource :webpages do
          helpers Helpers::PaginationHelper
          helpers Helpers::WebpagesHelper

          desc 'Show all webpages', { entity: Entities::Webpage, nickname: 'showAllWebpage' }
          params do
            use :pagination
          end
          get do
            authorize! :view, ::Webpage
            require_scope! :'view:webpage'

            @webpage = ::Webpage.order(created_at: :desc).page(page).per(per_page)
            set_pagination_headers(@webpage, 'webpage')
            present @webpage, with: Entities::Webpage
          end

          desc 'Get webpage', { entity: Entities::Webpage, nickname: 'showWebpage' }
          get ':id' do
            require_scope! :'view:webpage'
            authorize! :view, webpage!

            present webpage, with: Entities::Webpage
          end

          desc 'Create webpage', { entity: Entities::Webpage, params: Entities::Webpage.documentation, nickname: 'createWebpage' }
          post do
            require_scope! :'modify:webpage'
            authorize! :create, ::Webpage

            webpage_params = params[:webpage] || params

            @webpage = ::Webpage.new(declared(webpage_params, { include_missing: false }, Entities::Webpage.documentation.keys))
            webpage.user = current_user!
            webpage.save!

            present webpage, with: Entities::Webpage
          end

          desc 'Update webpage', { entity: Entities::Webpage, params: Entities::Webpage.documentation, nickname: 'updateWebpage' }
          put ':id' do
            require_scope! :'modify:webpage'
            authorize! :update, webpage!

            webpage_params = params[:webpage] || params
            allowed_params = remove_params(Entities::Webpage.documentation.keys, :tile_thumbnail, :user)

            webpage.update!(declared(webpage_params, { include_missing: false }, allowed_params))

            present webpage, with: Entities::Webpage
          end

          desc 'Delete webpage', { nickname: 'deleteWebpage' }
          delete ':id' do
            require_scope! :'modify:webpage'
            authorize! :delete, webpage!

            begin
              webpage.destroy
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
