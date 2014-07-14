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
        result.index(/\s/).nil? ? "#{result}*" : result
      end

      def or_null(field, q)
        result = { bool: {
            must: [],
            must_not: [],
            should: [
                {
                  terms: {
                    field => q
                  }
                },
                {
                  constant_score: {
                    filter: {
                      missing: { field: field }
                    }
                  }
                }
            ]
        } }
      end

      def terms_search(field, q)
        result = { bool: {
            must: [ { terms: { field => q } } ],
            must_not: [],
            should: []
        } }
      end

      def range_search(field, type, q)
        result = { bool: {
          must: [ { range: { field => { type => q } } } ],
          must_not: [],
          should: []
        } }
      end
    end

  end
end