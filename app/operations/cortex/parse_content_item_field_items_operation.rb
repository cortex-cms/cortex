require 'dry/transaction/operation'

module Cortex
  class ParseContentItemFieldItemsOperation
    include Dry::Transaction::Operation
    include Cortex::WidgetParsable

    def call(input)
      input.field_items.each do |field_item|
        if field_item.field.metadata && field_item.field.metadata['parse_widgets']
          parse_widgets!(field_item)
        end
      end

      Success(input)
    end
  end
end
