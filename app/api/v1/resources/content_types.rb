module V1
  module Resources
    class ContentTypes < Grape::API
      resource :content_types do

        desc 'Show all content types'
        get do
          require_scope! 'view:content_types'
          authorize! :view, ::ContentType
          @content_types = ContentType.all
          @content_types = ContentType.all
          ::V1::Entities::ContentType.represent @content_types
        end

        get ':id' do
          require_scope! 'view:content_types'
          authorize! :view, ::ContentType
          @content_type = ContentType.find(params[:id])
          present @content_type, with: ::V1::Entities::ContentType, fields: true
        end
      end
    end
  end
end
