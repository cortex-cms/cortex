require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Media < Grape::API
        helpers Helpers::SharedParams

        resource :media do
          helpers Helpers::PaginationHelper
          helpers Helpers::MediaHelper

          desc 'Show all media', { entity: Entities::Media, nickname: "showAllMedia" }
          params do
            use :pagination
            use :search
          end
          get do
            authorize! :view, ::Media
            require_scope! :'view:media'

            @media = ::GetMultipleMedia.call(params: declared(media_params, include_missing: false), page: page, per_page: per_page, tenant: find_current_user.tenant.id).media
            set_pagination_headers(@media, 'media')
            present @media, with: Entities::Media
          end

          desc 'Show media tags'
          params do
            optional :s
          end
          get 'tags' do
            require_scope! :'view:media'
            authorize! :view, ::Media

            tags = params[:s] \
              ? ::Media.tag_counts_on(:tags).where('name ILIKE ?', "%#{params[:s]}%") \
              : ::Media.tag_counts_on(:tags)

            if params[:popular]
              tags = tags.order('count DESC').limit(20)
            end

            present tags, with: Entities::Tag
          end

          desc 'Get media', { entity: Entities::Media, nickname: "showMedia" }
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
            if params[:tag_list]
              media.tag_list = params[:tag_list]
              media.save!
            end
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

            begin
              media.destroy
            rescue Cortex::Exceptions::ResourceConsumed => e
              error!({
                  error: "Conflict",
                  message: e.message,
                  status: 409
                     }, 409)
            end
          end
        end
      end
    end
  end
end
