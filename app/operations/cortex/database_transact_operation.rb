module Cortex
  DatabaseTransactOperation = -> (input, &block) {
    extend Dry::Monads::Result::Mixin

    result = nil

    ActiveRecord::Base.transaction do
      result = block.(Success(input))
      raise ActiveRecord::Rollback if result.failure?
    end

    result
  }
end
