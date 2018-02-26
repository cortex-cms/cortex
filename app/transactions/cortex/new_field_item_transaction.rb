module Cortex
  class NewFieldItemTransaction < Cortex::ApplicationTransaction
    include Cortex::FieldItemTransactor

    step :init
    step :process_plugin_transaction

    def init(field_item_attributes)
      Success(Cortex::FieldItem.new(field_item_attributes))
    end

    def process_plugin_transaction(field_item)
      Success(transact_new(field_item) || field_item)
    end
  end
end
