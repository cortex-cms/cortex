module Cortex
  class UpdateContentItemTransaction < Cortex::ApplicationTransaction
    include Dry::Transaction(container: Cortex::TransactionContainer)
    include Cortex::ContentItemable

    around :database_transact, with: "cortex.database_transact"
    step :init
    step :process
    step :latest_history_patch
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
        content_item = ContentItem.find(input.id)
        field_items_attributes(input.content_item_params).each do |_key, field_item_attributes|
          content_item.field_items << UpdateFieldItemTransaction.new.call(field_item_attributes).value!
        end

        input.content_item_params.delete('field_items_attributes')
        content_item.assign_attributes(input.content_item_params)
      end

      Success({
                content_item: content_item,
                current_user: input.current_user
              })
    end

    def latest_history_patch(input)
      history_patch = {}
      history_patch.merge! last_updated_by(input[:current_user])

      input[:content_item].assign_attributes(history_patch)
      Success(input[:content_item])
    end
  end
end
