module Cortex
  module SearchableContentItemForContentType
    extend ActiveSupport::Concern

    included do
      after_commit on: [:create] do
        self.class.__elasticsearch__.create_index!(index: content_items_index_name, mappings: content_item_mappings)
      end

      after_commit on: [:destroy] do
        self.class.__elasticsearch__.delete_index!(index: content_items_index_name)
      end

      after_commit on: [:update] do
        self.class.__elasticsearch__.delete_index!(index: content_items_index_name)
        self.class.__elasticsearch__.create_index!(index: content_items_index_name, mappings: content_item_mappings)
        # TODO: implement & move import to ContentItem to mass-refresh all ContentItems for a ContentType
        #self.class.__elasticsearch__.import()
      end

      def content_items_index_name
        @content_items_index_name ||= "#{Rails.env}_content_type_#{name_id}_content_items"
      end
    end

    private

    def content_item_mappings
      mappings = Elasticsearch::Model::Indexing::Mappings.new(content_items_index_name, { dynamic: false })
      mappings.indexes :tenant_id, type: :keyword, index: :not_analyzed
      mappings.indexes :content_type_id, type: :keyword, index: :not_analyzed
      mappings.indexes :creator_id, type: :keyword, index: :not_analyzed
      mappings.indexes :updated_by_id, type: :keyword, index: :not_analyzed
      mappings.indexes :state, analyzer: :keyword, index: :not_analyzed
      mappings.indexes :created_at, type: :date, include_in_all: false
      mappings.indexes :updated_at, type: :date, include_in_all: false
      mappings.indexes :deleted_at, type: :date, include_in_all: false

      fields.each do |field|
        mappings.indexes field.elasticsearch_mapping[:name], content_item_field_mappings(field)
      end

      mappings
    end

    def content_item_field_mappings(field)
      mappings = { type: field.elasticsearch_mapping[:type] }
      mappings[:analyzer] = field.elasticsearch_mapping[:analyzer] if field.elasticsearch_mapping[:analyzer]
      mappings
    end
  end
end
