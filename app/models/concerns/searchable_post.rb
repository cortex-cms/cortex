module SearchablePost
  extend ActiveSupport::Concern

  included do
    include Searchable

    mapping do
      indexes :id,                :index => :not_analyzed
      indexes :title,             :analyzer => 'snowball'
      indexes :body,              :analyzer => 'snowball'
      indexes :draft,             :type => 'boolean'
      indexes :short_description, :analyzer => 'snowball'
      indexes :copyright_owner,   :analyzer => 'keyword'
      indexes :author,            :analyzer => 'keyword'
      indexes :created_at,        :type => 'date', :include_in_all => false
      indexes :published_at,      :type => 'date', :include_in_all => false
      indexes :tags,              :analyzer => :keyword
      indexes :categories,        :analyzer => :keyword
      indexes :job_phase,         :analyzer => :keyword
      indexes :type,              :analyzer => :keyword
      indexes :industries,        :analyzer => :keyword
    end

    def related(published = nil)
      # Filter the current post from results, this is not necessary with ES 1.2
      filter_bool = {must_not: { ids: { values: [id] } } }

      if published
        filter_bool[:must] = [ { range: { published_at: { lte: DateTime.now } } }, { terms: { 'draft' => [false] } } ]
      end

      mlt_fields = [
        {
          job_phase: {
            like_text: job_phase,
            min_doc_freq: 1,
            min_term_freq: 1
          }
        },
        {
          categories: {
            like_text: categories.pluck(:name).join(' '),
            min_doc_freq: 1,
            min_term_freq: 1
          }
        },
        {
          tags: {
            like_text: tag_list.join(' '),
            min_doc_freq: 1,
            min_term_freq: 1
          }
        }
      ]

      query_should = mlt_fields.map{ |f| {more_like_this_field: f} }

      query  = {
        bool: {
          should: query_should
        }
      }

      Post.search query: {filtered: { query: query, filter: {bool: filter_bool} } }
    end

    def as_indexed_json(options = {})
      json = as_json(only: [:id, :title, :body, :draft, :short_description, :copyright_owner,
                            :created_at, :published_at, :job_phase, :type])
      json[:categories] = categories.collect{ |c| c.name }
      json[:industries] = industries.collect{ |i| i.soc }
      json[:tags]       = tag_list.to_a
      json[:author]     = author ? author.fullname : custom_author
      json
    end
  end

  module ClassMethods
    def search_with_params(params, published = nil)
      query = { query_string: { fields: ['title^100', '_all'], query: self.query_massage(params[:q]) } }

      categories = params[:categories]
      job_phase  = params[:job_phase]
      post_type  = params[:post_type]
      industries = params[:industries]
      author     = params[:author]
      bool = { bool: { must: [ query ], must_not: [], should: [] } }

      if categories; bool[:bool][:must] << self.terms_search('categories', categories.split(',')) end
      if job_phase; bool[:bool][:must] << self.terms_search('job_phase', job_phase.split(',')) end
      if post_type; bool[:bool][:must] << self.terms_search('type', post_type.split(',')) end
      if industries; bool[:bool][:must] << self.or_null('industries', industries.split(',')) end
      if author; bool[:bool][:must] << self.or_null('author', [author]) end
      if published; bool[:bool][:must] << self.range_search('published_at', 'lte', DateTime.now); bool[:bool][:must] << self.terms_search('draft', [false]) end

      self.search query: bool, size: 60
    end
  end
end

# example search_with_params ES query
# -----------------------------------
# {
#   "query": {
#     "query_string": {"query": "*"}
#   },
#   "filter": {
#     "and": {
#       "filters": [
#         {
#           "terms": {
#             "categories": ["Assessments"],
#             "job_phase": ["discovery"]
#           }
#         },
#         {
#           "range": {
#             "published_at": {"lte": "2014-05-22T19:47:16.005Z"}
#           }
#         }
#       ]
#     }
#   }
# }
