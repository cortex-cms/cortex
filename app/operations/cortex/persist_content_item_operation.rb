require 'dry/transaction/operation'

module Cortex
  class PersistContentItemOperation
    include Dry::Transaction::Operation

    def call(input)
      if input.save
        Success(input)
      else
        Failure(input.errors)
      end
    end
  end
end
