module Cortex
  class CreateContentItemTransaction < Cortex::ApplicationTransaction
    include Dry::Transaction(container: Cortex::TransactionContainer)
    include Cortex::ContentItemable

    around :database_transact, with: "cortex.database_transact"
    step :init
    step :process
    step :parse_content_item_field_items, with: "cortex.parse_content_item_field_items"
    step :persist_content_item, with: "cortex.persist_content_item"
    step :execute_content_item_state_change, with: "cortex.execute_content_item_state_change"

    def init(input)
      Success(ContentItemTransactionType.new(input))
    end

    def process(input)
      if input.content_item
        content_item = input.content_item
      else
        content_item = ContentItem.new
        field_items_attributes(input.content_item_params).each do |_key, field_item_attributes|
          field_item_attributes.delete('id')
          content_item.field_items << NewFieldItemTransaction.new.call(field_item_attributes).value!
        end

        content_item.attributes = input.content_item_params.except('field_items_attributes')
      end

      content_item.tenant = input.current_user.active_tenant # TODO: In future, grab from form/route, rather than current_user + perform authorization checks

      Success(content_item)
    end
  end
end
