class UpdateFieldItemTransaction < ApplicationTransaction
  include FieldItemTransactor

  step :init
  step :process_plugin_transaction

  def init(field_item_attributes)
    field_item = FieldItem.find_by_id(field_item_attributes['id'])

    if field_item
      field_item.assign_attributes(field_item_attributes)
      Right(field_item)
    else
      Left(:not_found)
    end
  end

  def process_plugin_transaction(field_item)
    Right(transact_update(field_item) || field_item)
  end
end
