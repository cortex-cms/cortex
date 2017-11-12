Types::ContentTypeType = GraphQL::ObjectType.define do
  name 'ContentType'
  description 'Content model set forth by a superadministrator. ContentItems are created from this.'

  field :id, !types.ID
  field :name, !types.String
  field :description, types.String
  field :publishable, !types.Boolean
  field :icon, types.String
  field :contract, !Types::ContractType
  field :tenant, !Types::TenantType
  field :creator, !Types::UserType

  field :updated_by, Types::UserType
  field :created_at, !Types::DateTimeType
  field :updated_at, !Types::DateTimeType
  field :deleted_at, Types::DateTimeType

  # TODO: Fields
end
