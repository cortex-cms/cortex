module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name "#{Rails.env}_#{model_name.to_s.parameterize(separator: '_')}"
  end
end
