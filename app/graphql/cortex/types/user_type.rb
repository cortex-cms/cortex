module Cortex
  Types::UserType = GraphQL::ObjectType.define do
    name 'User'
    description 'Cortex administrator or content creator'

    field :id, !types.ID
    field :firstname, !types.String
    field :lastname, !types.String
    field :locale, !types.String
    field :timezone, !types.String
    field :created_at, !Cortex::Types::DateTimeType
    field :updated_at, !Cortex::Types::DateTimeType
    field :deleted_at, Cortex::Types::DateTimeType

    field :tenants, !types[Cortex::Types::TenantType]
    field :active_tenant, !types[Cortex::Types::TenantType]

    # TODO: Owned ContentItems, etc
  end
end
