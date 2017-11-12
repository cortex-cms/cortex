Types::FieldType = GraphQL::ObjectType.define do
  name 'Field'
  description 'Configured FieldTypes that make up a ContentType'

  field :id, !types.ID
  field :name, !types.String
  field :field_type, !types.String
  field :metadata, !types.String
  field :validations, !types.String
  field :content_type, !Types::ContentTypeType

  field :created_at, !Types::DateTimeType
  field :updated_at, !Types::DateTimeType
  field :deleted_at, Types::DateTimeType
end
