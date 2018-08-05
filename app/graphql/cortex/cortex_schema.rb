module Cortex
  CortexSchema = GraphQL::Schema.define do
    use ApolloTracing.new

    # mutation(Cortex::Types::MutationType)
    query(Cortex::Types::QueryType)
  end
end
