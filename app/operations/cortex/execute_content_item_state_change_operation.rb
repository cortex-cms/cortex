require 'dry/transaction/operation'

module Cortex
  class ExecuteContentItemStateChangeOperation
    include Dry::Transaction::Operation
    include Cortex::ContentItemable

    def call(input, state:)
      execute_state_change(input, state)
      Success(input)
    end
  end
end
