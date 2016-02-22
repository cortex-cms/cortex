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
        indexes :id, :index => :not_analyzed
        indexes :name, :analyzer => :snowball, :boost => 100.0
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
      json[:tags]       = tag_list.to_a if respond_to? :tag_list
      json[:taxon]      = create_taxon if respond_to? :create_taxon
      json
    end
  end

  module ClassMethods
    # TODO: Rewrite to handle filters
    def search_with_params(params)
      query = { query_string: { fields: %w[name^100 _all], query: query_massage(params[:q]) } }

      bool = { bool: { must: [query], must_not: [], should: [] } }

      search size: 30, query: bool, sort: [{ created_at: { order: :desc } }]
    end
  end
end
