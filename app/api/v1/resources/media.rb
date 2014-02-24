#require_relative '../helpers/resource_helper'

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
      end
    end

    class Media < Grape::API
      helpers Helpers::SharedParams
      helpers MediaParams

      resource :media do
        helpers Helpers::PaginationHelper
        helpers Helpers::MediaHelper

        desc 'Show all media'
        get do
          present Media.order(created_at: :desc).page(page).per(per_page), with: Entities::Media
        end

        desc 'Search for media'
        params do
          use :pagination
        end
        get :search do
          q = params[:q]
          if q.to_s != ''
            @media = ::Media.search :load => true, :page => page, :per_page => per_page do
              query { string q }
              sort { by :created_at, :desc }
            end
          else
            @media = ::Media.order(created_at: :desc).page(page).per(per_page)
          end

          set_pagination_headers(@media, 'media')
          present @media, with: Entities::Media
        end

        desc 'Get media'
        get ':id' do
          present media!, with: Entities::Media
        end

        desc 'Create media'
        params do
          use :media_params
        end
        post do
          @media = ::Media.new(declared(params[:media]))
          media.user = current_user!
          media.save!
          present media, with: Entities::Media
        end

        desc 'Update media'
        params do
          use :media_params
        end
        put ':id' do
          media!.update!(declared(params[:media], include_missing: false))
          if params[:tag_list]
            media.tag_list = params[:tag_list]
            media.save!
          end
          present media, with: Entities::Media
        end

        desc 'Delete media'
        delete ':id' do
          media!.destroy
        end
      end
    end
  end
end
