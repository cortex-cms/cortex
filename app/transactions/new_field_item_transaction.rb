class NewFieldItemTransaction < ApplicationTransaction
  include FieldItemTransactor

  step :init
  step :process_plugin_transaction

  def init(field_item_attributes)
    Right(FieldItem.new(field_item_attributes))
  end

  def process_plugin_transaction(field_item)
    Right(transact_new(field_item) || field_item)
  end
end
