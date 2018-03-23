module Cortex
  Types::FieldItemType = GraphQL::ObjectType.define do
    name 'FieldItem'
    description 'Individual fields storing content that make up a ContentItem'

    field :id, !types.ID
    field :data, !types.String
    field :field, !Cortex::Types::FieldType
    field :content_item, !Cortex::Types::ContentItemType

    field :created_at, !Cortex::Types::DateTimeType
    field :updated_at, !Cortex::Types::DateTimeType
    field :deleted_at, Cortex::Types::DateTimeType
  end
end
