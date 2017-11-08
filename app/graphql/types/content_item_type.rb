Types::ContentItemType = GraphQL::ObjectType.define do
  name 'ContentItem'
  description 'Content created by a Content Creator from a ContentType'

  field :id, !types.ID
  field :tenant, !Types::TenantType
  field :creator, !Types::UserType
  field :updated_by, Types::UserType
  field :content_type, !Types::ContentTypeType
end
