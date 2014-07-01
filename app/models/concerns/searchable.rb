module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    index_name [Rails.env, model_name.collection.gsub(/\//, '-')].join('_')

    class << self
      def query_massage q
        result = q.chomp.strip
        if result.empty?; return '*' end
        result.index(/\s/).nil? ? "#{result}*" : result
      end
    end

  end
end