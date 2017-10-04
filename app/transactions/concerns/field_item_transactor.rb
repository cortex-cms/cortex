module FieldItemTransactor
  extend ActiveSupport::Concern

  included do
    # TODO: DRY all this up
    def plugin_new_transaction_klass(field_item)
      "new_#{field_type_name(field_item)}_field_item_transaction".classify.safe_constantize
    end

    def plugin_update_transaction_klass(field_item)
      "update_#{field_type_name(field_item)}_field_item_transaction".classify.safe_constantize
    end

    def field_type_name(field_item)
      field_item.field.field_type.chomp '_field_type'
    end

    def transact_new(field_item)
      plugin_new_transaction_klass(field_item)&.new&.call(field_item)&.value
    end

    def transact_update(field_item)
      plugin_update_transaction_klass(field_item)&.new&.call(field_item)&.value
    end
  end
end
