require 'dry/transaction/operation'

module Cortex
  class ParseContentItemFieldItemsOperation
    include Dry::Transaction::Operation
    include Cortex::ContentItemable

    def call(input)
      content_item = parse_field_items!(input)
      Success(content_item)
    end
  end
end
