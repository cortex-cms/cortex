module V1
  module Resources
    class ContentItems < Grape::API
      resource :content_items do
        desc "Create a content item", { entity: ::V1::Entities::ContentItem, params: ::V1::Entities::ContentItem.documentation, nickname: "createContentItem" }
        params do
          requires :content_type_id, type: Integer, desc: "content type of content item"
        end
        post do
          require_scope! 'create:content_items'
          authorize! :create, ::ContentItem
          @content_item = ::ContentItem.new(params.merge(author_id: current_user.id, creator_id: current_user.id))

          if @content_item.save
            present @content_item, with: ::V1::Entities::ContentItem, full: true
          else
            status 400
            { error: @content_item.errors.full_messages.join("\n") }
          end
        end

        desc 'Show all content items', { entity: ::V1::Entities::ContentItem, nickname: "showAllContentItems" }
        get do
          require_scope! 'view:content_items'
          authorize! :view, ::ContentItem
          @content_items = ::ContentItem.all

          present @content_items, with: ::V1::Entities::ContentItem, field_items: true
        end
      end
    end
  end
end
