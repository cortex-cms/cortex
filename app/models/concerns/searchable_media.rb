module SearchableMedia
  extend ActiveSupport::Concern

  included do
    include Searchable

    settings :analysis => {
        :analyzer => {
            :taxon_analyzer => {
                :type => 'custom',
                :tokenizer => 'standard',
                :filter => %w(standard lowercase ngram)
            }
        }
    } do
      mapping do
        indexes :id, :type => :integer, :index => :not_analyzed
        indexes :tenant_id, :type => :integer, :index => :not_analyzed
        indexes :name, :analyzer => :snowball
        indexes :created_by, :analyzer => :keyword
        indexes :file_name, :analyzer => :keyword
        indexes :description, :analyzer => :snowball
        indexes :tag_list, :type => :string, :analyzer => :keyword
        indexes :created_at, :type => :date, :include_in_all => false
        indexes :taxon, :analyzer => :taxon_analyzer
        indexes :meta, :type => :object
      end
    end

    def as_indexed_json(options = {})
      json = as_json(options)
      json[:created_by] = user.fullname
      json[:tags]       = tag_list.to_a
      json[:taxon]      = create_taxon
      json[:tenant_id]  = user.tenant.id
      json
    end
  end

  module ClassMethods
    # TODO: Rewrite to handle facets
    def search_with_params(params, tenant)
      query = { multi_match: { fields: %w(name^2 _all), query: query_massage(params[:q]) } }
      filter = { term: { tenant_id: tenant.id } }
      bool = { bool: { must: [query], filter: [filter] } }

      search query: bool
    end

    def show_all(tenant)
      filter = { term: { tenant_id: tenant.id } }
      bool = { bool: { filter: [filter] } }

      search query: bool, sort: [{ created_at: { order: :desc } }]
    end
  end
end
