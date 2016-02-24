module SearchableWebpage
  extend ActiveSupport::Concern

  included do
    include Searchable

    mapping do
      indexes :id, :type => :integer, :index => :not_analyzed
      indexes :name, :analyzer => :snowball, :boost => 100.0
      indexes :url, :analyzer => :keyword
      indexes :created_by, :analyzer => :keyword
      indexes :created_at, :type => :date, :include_in_all => false
    end

    def as_indexed_json(options = {})
      json = as_json(options)
      json[:created_by] = user.fullname
      json
    end
  end

  module ClassMethods
    # TODO: Rewrite to handle filters
    def search_with_params(params)
      query = { query_string: { fields: %w[name^100 _all], query: query_massage(params[:q]) } }

      bool = { bool: { must: [query], must_not: [], should: [] } }

      search size: 60, query: bool, sort: [{ created_at: { order: :desc } }]
    end
  end
end
