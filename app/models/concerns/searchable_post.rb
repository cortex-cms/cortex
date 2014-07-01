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
        filter_bool[:must] = { range: { published_at: { lte: DateTime.now } } }
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
                            :author, :created_at, :published_at, :job_phase, :type])
      json[:categories] = categories.collect{ |c| c.name }
      json[:industries] = industries.collect{ |i| i.soc }
      json[:tags]       = tag_list
      json
    end
  end

  module ClassMethods
    def search_with_params(params, published = nil)
      query = { query_string: { query: self.query_massage(params[:q]) } }
      filter = { and: { filters: [] } }
      sort = { created_at: :desc }

      categories = params[:categories]
      job_phase  = params[:job_phase]
      post_type  = params[:post_type]
      industries = params[:industries]

      # terms filter
      if categories || job_phase || post_type || industries
        terms = {}

        if categories; terms[:categories] = categories.split(',') end
        if job_phase; terms[:job_phase]   = job_phase.downcase().split(',') end
        if post_type; terms[:type]        = post_type.downcase().split(',') end
        if industries; terms[:industries] = industries.split(',') end

        filter[:and][:filters] << {terms: terms}
      end

      if published; filter[:and][:filters] << { range: { published_at: { lte: DateTime.now } } } end

      self.search query: query, filter: filter, sort: sort
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
