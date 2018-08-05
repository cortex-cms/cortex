require 'dry/transaction/operation'

module Cortex
  class ExecuteContentItemStateChangeOperation
    include Dry::Transaction::Operation

    def call(input, state:)
      if state && input.can_transition?(state)
        state_method = "#{state}!"
        input.send(state_method)
      end

      Success(input)
    end
  end
end
