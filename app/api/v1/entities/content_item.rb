module V1
  module Entities
    class ContentItem < Grape::Entity
      expose :id, documentation: {type: "Integer", desc: "Content Item ID", required: true}
      expose :publish_state, documentation: {type: "String", desc: "Publish state", required: true}
      expose :creator, documentation: {type: "dateTime", desc: "Date published", required: true} do |content_item|
        content_item.creator.fullname
      end
      expose :content_type, documentation: {type: "String", desc: "Name of content type", required: true} do |content_item|
        content_item.content_type.name
      end

      with_options if: { field_items: true } do
        expose :field_items, using: '::V1::Entities::FieldItem', documentation: { type: "FieldItems", is_array: true, desc: "Associated field items" }
      end
    end
  end
end
