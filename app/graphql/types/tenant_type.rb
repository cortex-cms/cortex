Types::TenantType = GraphQL::ObjectType.define do
  name 'Tenant'
  description 'Tenants segregate and nest users and content'

  field :id, !types.ID
  field :name, !types.String
  field :name_id, !types.String
  field :description, !types.String
  field :parent, types[Types::TenantType]
  field :children, types[Types::TenantType]
  field :owner, !types[Types::UserType]
  field :created_at, !Types::DateTimeType
  field :updated_at, !Types::DateTimeType
  field :deleted_at, Types::DateTimeType

  # TODO: Owned ContentItems, etc
end
