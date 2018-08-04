module Cortex
  class TransactionContainer
    extend Dry::Container::Mixin

    namespace "cortex" do
      register "database_transact" do
        Cortex::DatabaseTransactOperation
      end

      register "parse_content_item_field_items" do
        Cortex::ParseContentItemFieldItemsOperation.new
      end

      register "persist_content_item" do
        Cortex::PersistContentItemOperation.new
      end

      register "execute_content_item_state_change" do
        Cortex::ExecuteContentItemStateChangeOperation.new
      end
    end
  end
end
