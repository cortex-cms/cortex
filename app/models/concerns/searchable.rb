module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name "#{Rails.env}_#{model_name.to_s.parameterize(separator: '_')}"

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
    end
  end
end
