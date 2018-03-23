module Cortex
  Types::TenantType = GraphQL::ObjectType.define do
    name 'Tenant'
    description 'Tenants segregate and nest users and content'

    field :id, !types.ID
    field :name, !types.String
    field :name_id, !types.String
    field :description, !types.String
    field :parent, types[Cortex::Types::TenantType]
    field :children, types[Cortex::Types::TenantType]
    field :owner, !types[Cortex::Types::UserType]
    field :created_at, !Cortex::Types::DateTimeType
    field :updated_at, !Cortex::Types::DateTimeType
    field :deleted_at, Cortex::Types::DateTimeType

    # TODO: Owned ContentItems, etc
  end
end
