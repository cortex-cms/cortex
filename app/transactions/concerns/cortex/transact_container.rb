module Cortex
  class TransactContainer
    extend Dry::Container::Mixin
    extend Dry::Monads::Result::Mixin

    register(:transact) do |input, &block|
      result = nil

      ActiveRecord::Base.transaction do
        block
        parse_field_items!
        @content_item.save!
        execute_state_change(@content_item)
      end

      begin
        MyDB.transaction do
          result = block.(Success(input))
          raise MyDB::Rollback if result.failure?
          result
        end
      rescue Test::Rollback
        result
      end
    end
  end
end
