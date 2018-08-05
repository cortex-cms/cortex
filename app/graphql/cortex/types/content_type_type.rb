module Cortex
  Types::ContentTypeType = GraphQL::ObjectType.define do
    name 'ContentType'
    description 'Content model set forth by a superadministrator. ContentItems are created from this.'

    field :id, !types.ID
    field :name, !types.String
    field :name_id, !types.String
    field :description, types.String
    field :publishable, !types.Boolean
    field :icon, types.String
    field :contract, !Cortex::Types::ContractType
    field :tenant, !Cortex::Types::TenantType
    field :creator, !Cortex::Types::UserType

    field :updated_by, Cortex::Types::UserType
    field :created_at, !Cortex::Types::DateTimeType
    field :updated_at, !Cortex::Types::DateTimeType
    field :deleted_at, Cortex::Types::DateTimeType

    # TODO: Fields
  end
end
