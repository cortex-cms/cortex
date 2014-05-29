module SearchablePost
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

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
      indexes :tags,              :analyzer => :keyword, :as => 'tag_list'
      indexes :categories,        :analyzer => :keyword, :as => 'categories.collect{ |c| c.name }'
      indexes :job_phase,         :analyzer => :keyword
      indexes :type,              :analyzer => :keyword, :as => 'type'
      indexes :industries,        :analyzer => :keyword, :as => 'industry.soc'
    end

    def related(published = nil)
      Post.search query: {
        mlt: {
          fields: %w(job_phase categories tags),
          like_text: "#{job_phase} #{categories.pluck(:name).join(' ')} #{tag_list.join(' ')}",
          # ids: [id], // Requires ES 1.2
          min_doc_freq: 1,
          min_term_freq: 1
        }
      }
    end
  end

  module ClassMethods
    def search_with_params(params, published = nil)
      query  = { query_string: { query: params[:q] || '*' } }
      filter = { and: { filters: [] } }
      sort = sort { by :created_at, :desc }

      categories = params[:categories]
      job_phase  = params[:job_phase]
      post_type  = params[:post_type]

      # terms filter
      if categories || job_phase || post_type
        terms = {}

        if categories; terms[:categories] = categories.split(',') end
        if job_phase; terms[:job_phase] = job_phase.downcase().split(',') end
        if post_type; terms[:type] = post_type.downcase().split(',') end

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
