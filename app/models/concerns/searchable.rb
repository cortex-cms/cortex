module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    index_name [Rails.env, model_name.collection.gsub(/\//, '-')].join('_')

    class << self
      def query_massage q
        return '*' if q.nil? or q.empty?
        result = q.chomp.strip
        return '*' if result.nil? or result.empty?
        result.index(/\s|\-/).nil? ? "#{result}*" : result
      end

      def term_search(field, q)
        result = {
          term: { field => q }
        }
      end

      def terms_search(field, q)
        result = {
          terms: { field => q }
        }
      end

      def range_search(field, type, q)
        result = {
          range: { field => { type => q } }
        }
      end

      def published_filter
        # Bring in documents based on Draft status, Published date met, or either: Expired date not yet met, or Expired date null
        [
          {bool: {must: [term_search(:draft, false)]}},
          {bool: {must: [range_search(:published_at, :lte, DateTime.now.to_s)]}},
          {bool: {should: [range_search(:expired_at, :gte, DateTime.now.to_s), {bool: {must_not: {exists: { field: :expired_at }}}}]}}
        ]
      end

      def published_or_scheduled_filter
        [
          {bool: {must: [term_search(:draft, false)]}},
          {bool: {should: [range_search(:expired_at, :gte, DateTime.now.to_s), {bool: {must_not: {exists: { field: :expired_at }}}}]}}
        ]
      end
    end
  end
end
