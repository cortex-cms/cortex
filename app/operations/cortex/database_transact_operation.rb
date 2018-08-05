module Cortex
  DatabaseTransactOperation = -> (input, &block) {
    extend Dry::Monads::Result::Mixin

    result = nil

    begin
      ActiveRecord::Base.transaction do
        result = block.(Success(input))
        raise ActiveRecord::Rollback if result.failure?
        result
      end
    rescue ActiveRecord::Rollback
      result
    end
  }
end
