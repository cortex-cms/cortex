module Cortex
  CortexSchema = GraphQL::Schema.define do
    use ApolloTracing.new

    # mutation(Types::MutationType)
    query(Types::QueryType)
  end
end
