module SearchableUser
  extend ActiveSupport::Concern

  included do
    include Searchable

    mapping do
      indexes :id, :type => :integer, :index => :not_analyzed
      indexes :tenant_id, :type => :integer, :index => :not_analyzed
      indexes :email, :analyzer => :snowball
      indexes :fullname, :analyzer => :keyword
      indexes :created_at, :type => :date, :include_in_all => false
    end

    def as_indexed_json(options = {})
      json = as_json(options)
      json[:tenant_id]  = tenant.id
      json
    end
  end

  module ClassMethods
    def search_with_params(params, tenant_id)
      query = { match: { '_all': query_massage(params[:q]) } }
      filter = { term: { tenant_id: tenant_id } }
      bool = { bool: { must: [query], filter: [filter] } }

      search query: bool
    end

    def show_all(tenant_id)
      filter = { term: { tenant_id: tenant_id } }
      bool = { bool: { filter: [filter] } }

      search query: bool, sort: [{ created_at: { order: 'desc' } }]
    end
  end
end
