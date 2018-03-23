module Cortex
  Types::FieldType = GraphQL::ObjectType.define do
    name 'Field'
    description 'Configured FieldTypes that make up a ContentType'

    field :id, !types.ID
    field :name, !types.String
    field :name_id, !types.String
    field :field_type, !types.String
    field :metadata, !types.String
    field :validations, !types.String
    field :content_type, !Cortex::Types::ContentTypeType

    field :created_at, !Cortex::Types::DateTimeType
    field :updated_at, !Cortex::Types::DateTimeType
    field :deleted_at, Cortex::Types::DateTimeType
  end
end
