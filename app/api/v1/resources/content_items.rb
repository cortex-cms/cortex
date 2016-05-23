module V1
  module Resources
    class ContentItems < Grape::API
      resource :content_items do
        desc "Create a content item", { entity: ::V1::Entities::ContentItem, params: ::V1::Entities::ContentItem.documentation, nickname: "createContentItem" }
        params do
          requires :publish_state, type: String, desc: "publish state of content item"
        end
        post do
          @content_item = ::ContentItem.new(params)

          if @content_item.save
            present @content_item, with: ::V1::Entities::ContentItem, full: true
          else
            status 400
            { error: "Missing attributes on content item and/or field items"}
          end
        end
      end
    end
  end
end
