require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    module MediaParams
      extend Grape::API::Helpers

      params :media_params do
        optional :name
        optional :attachment
        optional :description
        optional :alt
        optional :active
        optional :deactive_at
        optional :tag_list
        optional :type
        optional :video_id # youtube
      end
    end

    class Media < Grape::API
      helpers Helpers::SharedParams
      # helpers MediaParams

      resource :media do
        helpers Helpers::PaginationHelper
        helpers Helpers::MediaHelper

        desc 'Show all media', { entity: Entities::Media, nickname: "showAllMedia" }
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

        desc 'Search for media', { entity: Entities::Media, nickname: "searchMedia" }
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

        desc 'Get media', { entity: Entities::Media, nickname: "getMedia" }
        get ':id' do
          require_scope! :'view:media'
          authorize! :view, media!

          present media, with: Entities::Media, full: true
        end

        desc 'Create media', { entity: Entities::Media, params: Entities::Media.documentation, nickname: "createMedia" }
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

        desc 'Update media', { entity: Entities::Media, params: Entities::Media.documentation, nickname: "updateMedia" }
        params do
          optional :attachment
        end
        put ':id' do
          require_scope! :'modify:media'
          authorize! :update, media!

          media_params = params[:media] || params

          media.update!(declared(media_params, { include_missing: false }, Entities::Media.documentation.keys))
          if params[:tag_list]
            media.tag_list = params[:tag_list]
            media.save!
          end
          present media, with: Entities::Media
        end

        desc 'Delete media', { nickname: "deleteMedia" }
        delete ':id' do
          require_scope! :'modify:media'
          authorize! :delete, media!

          media.destroy
        end
      end
    end
  end
end
