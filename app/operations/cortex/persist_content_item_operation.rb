require 'dry/transaction/operation'

module Cortex
  class PersistContentItemOperation
    include Dry::Transaction::Operation

    def call(input)
      input.save!
      Success(input)
    end
  end
end
