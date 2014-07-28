require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Media < Grape::API
        helpers Helpers::SharedParams

        resource :media do
          helpers Helpers::PaginationHelper
          helpers Helpers::MediaHelper

          desc 'Show all media', { entity: API::V1::Entities::Media, nickname: "showAllMedia" }
          params do
            use :pagination
          end
          get do
            authorize! :view, ::Media
            require_scope! :'view:media'

            @media = ::Media.order(created_at: :desc).page(page).per(per_page)

            set_pagination_headers(@media, 'media')
            present @media, with: Entities::Media
          end

          desc 'Search for media', { entity: API::V1::Entities::Media, nickname: "searchMedia" }
          params do
            use :pagination
            use :search
          end
          get :search do
            require_scope! :'view:media'
            authorize! :view, ::Media

            q = params[:q]
            if q.to_s != ''
              @media = ::Media.search_with_params(params).page(page).per(per_page).records
            else
              @media = ::Media.order(created_at: :desc).page(page).per(per_page)
            end

            set_pagination_headers(@media, 'media')
            present @media, with: Entities::Media
          end

          desc 'Get media', { entity: API::V1::Entities::Media, nickname: "showMedia" }
          get ':id' do
            require_scope! :'view:media'
            authorize! :view, media!

            present media, with: Entities::Media, full: true
          end

          desc 'Create media', { entity: API::V1::Entities::Media, params: API::V1::Entities::Media.documentation, nickname: "createMedia" }
          params do
            optional :attachment
          end
          post do
            require_scope! :'modify:media'
            authorize! :create, ::Media

            media_params = params[:media] || params

            @media = ::Media.new(declared(media_params, { include_missing: false }, Entities::Media.documentation.keys))
            media.user = current_user!
            media.save!
            present media, with: Entities::Media, full: true
          end

          desc 'Update media', { entity: API::V1::Entities::Media, params: API::V1::Entities::Media.documentation, nickname: "updateMedia" }
          params do
            optional :attachment
          end
          put ':id' do
            require_scope! :'modify:media'
            authorize! :update, media!

            media_params = params[:media] || params

            allowed_params = [:name, :alt, :description, :tag_list, :status, :expiration_date]

            media.update!(declared(media_params, { include_missing: false }, allowed_params))
            if params[:tag_list]
              media.tag_list = params[:tag_list]
              media.save!
            end
            present media, with: Entities::Media, full: true
          end

          desc 'Delete media', { nickname: "deleteMedia" }
          delete ':id' do
            require_scope! :'modify:media'
            authorize! :delete, media!

            unless media.destroy
              error!({
                  error: "UnprocessableEntity",
                  message: "This media cannot be deleted, as it is currently consumed by other content.",
                  status: 422
                     }, 422)
            end
          end
        end
      end
    end
  end
end
