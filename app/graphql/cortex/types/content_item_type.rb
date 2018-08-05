module Cortex
  Types::ContentItemType = GraphQL::ObjectType.define do
    name 'ContentItem'
    description 'Content created by a Content Creator from a ContentType'

    field :id, !types.ID
    field :state, types.String
    field :tenant, !Cortex::Types::TenantType
    field :creator, !Cortex::Types::UserType
    field :content_type, !Cortex::Types::ContentTypeType

    field :updated_by, Cortex::Types::UserType
    field :created_at, !Cortex::Types::DateTimeType
    field :updated_at, !Cortex::Types::DateTimeType
    field :deleted_at, Cortex::Types::DateTimeType

    field :allFieldItems, types[Cortex::Types::FieldItemType] do
      resolve -> (obj, _args, _ctx) {
        obj.field_items
      }
    end

    field :FieldItem, Cortex::Types::FieldItemType do
      argument :name_id, !types.String

      resolve -> (obj, args, _ctx) {
        obj.field_items.find { |field_item| field_item.field.name_id == args[:name_id] }
      }
    end
  end
end
