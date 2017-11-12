Types::ContentItemType = GraphQL::ObjectType.define do
  name 'ContentItem'
  description 'Content created by a Content Creator from a ContentType'

  field :id, !types.ID
  field :state, types.String
  field :tenant, !Types::TenantType
  field :creator, !Types::UserType
  field :content_type, !Types::ContentTypeType

  field :updated_by, Types::UserType
  field :created_at, !Types::DateTimeType
  field :updated_at, !Types::DateTimeType
  field :deleted_at, Types::DateTimeType

  field :allFieldItems, types[Types::FieldItemType] do
    resolve -> (obj, _args, _ctx) {
      obj.field_items
    }
  end

  field :FieldItem, Types::FieldItemType do
    argument :name, !types.String

    resolve -> (obj, args, _ctx) {
      obj.field_items.find { |field_item| field_item.field.name == args[:name] }
    }
  end
end
