module Cortex
  module SearchableContentItem
    extend ActiveSupport::Concern

    included do
      include Cortex::Searchable

      after_commit on: [:create] do
        __elasticsearch__.index_document(index: content_type.content_items_index_name)
      end

      after_commit on: [:update] do
        # Perform a full document re-index, as update_document ignores methods: https://github.com/elastic/elasticsearch-rails/issues/306#issuecomment-121817954
        __elasticsearch__.index_document(index: content_type.content_items_index_name)
      end

      after_commit on: [:destroy] do
        __elasticsearch__.delete_document(index: content_type.content_items_index_name)
      end

      def as_indexed_json(options = {})
        json = as_json
        field_items.each do |field_item|
          field_type = field_item.field.field_type_instance(field_name: field_item.field.name)
          json.merge!(field_type.field_item_as_indexed_json_for_field_type(field_item))
        end
        json
      end
    end
  end
end
