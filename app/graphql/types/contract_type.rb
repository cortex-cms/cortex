Types::ContractType = GraphQL::ObjectType.define do
  name 'Contract'
  description ''

  field :id, !types.ID

  # TODO: the whole thing
end
