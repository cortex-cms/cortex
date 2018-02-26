module Cortex
  class CreateContentItemTransaction < Cortex::ApplicationTransaction
    include Dry::Transaction(container: Cortex::TransactContainer)
    include Dry::Transaction(container: Cortex::RefreshContentItemContainer)
    include Cortex::ContentItemable
    include Cortex::WidgetParsable

    around :transact
    step :init
    step :process
    step :parse_field_items, with: "refresh_content_item.parse_field_items"
    step :persist, with: "refresh_content_item.persist"
    step :execute_state_change, with: "refresh_content_item.execute_state_change"

    def init(input)
      Success(ContentItemTransactionType.new(input))
    end

    def process(input)
      content_item = ContentItem.new
      field_items_attributes(input.content_item_params).each do |_key, field_item_attributes|
        field_item_attributes.delete('id')
        content_item.field_items << NewFieldItemTransaction.new.call(field_item_attributes).value
      end

      content_item.attributes = input.content_item_params.except('field_items_attributes')
      content_item.tenant = input.current_user.active_tenant # TODO: In future, grab from form/route, rather than current_user + perform authorization checks
      Success(content_item)
    end
  end
end
