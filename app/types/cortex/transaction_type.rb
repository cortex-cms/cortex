module Cortex
  class TransactionType < Dry::Struct
    constructor_type :schema

    attr_reader :errors
  end
end
