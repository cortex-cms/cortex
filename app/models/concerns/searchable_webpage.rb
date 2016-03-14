module SearchableWebpage
  extend ActiveSupport::Concern

  included do
    include Searchable

    mapping do
      indexes :id, :type => :integer, :index => :not_analyzed
      indexes :tenant_id, :type => :integer, :index => :not_analyzed
      indexes :name, :analyzer => :snowball
      indexes :url, :analyzer => :keyword
      indexes :created_by, :analyzer => :keyword
      indexes :created_at, :type => :date, :include_in_all => false
    end

    def as_indexed_json(options = {})
      json = as_json(options)
      json[:created_by] = user.fullname
      json[:tenant_id]  = user.tenant.id
      json
    end
  end

  module ClassMethods
    def search_with_params(params, tenant)
      query = { multi_match: { fields: %w(name^2 _all), query: query_massage(params[:q]) } }
      filter = { term: { tenant_id: tenant.id } }
      bool = { bool: { must: [query], filter: [filter] } }

      search query: bool
    end

    def show_all(tenant)
      filter = { term: { tenant_id: tenant.id } }
      bool = { bool: { filter: [filter] } }

      search query: bool, sort: [{ created_at: { order: 'desc' } }]
    end
  end
end
