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
    end

  end
end