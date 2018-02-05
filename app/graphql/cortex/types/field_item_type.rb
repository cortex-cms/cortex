module Cortex
  Types::FieldItemType = GraphQL::ObjectType.define do
    name 'FieldItem'
    description 'Individual fields storing content that make up a ContentItem'

    field :id, !types.ID
    field :data, !types.String
    field :field, !Types::FieldType
    field :content_item, !Types::ContentItemType

    field :created_at, !Types::DateTimeType
    field :updated_at, !Types::DateTimeType
    field :deleted_at, Types::DateTimeType
  end
end
