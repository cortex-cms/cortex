module Cortex
  Types::MutationType = GraphQL::ObjectType.define do
    name 'Mutation'

    field :createBulkUpload, field: Cortex::BulkUploadMutations::Create.field
  end
end
