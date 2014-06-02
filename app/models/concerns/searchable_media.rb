module SearchableMedia
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

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
        indexes :created_by, :analyzer => :keyword, :as => 'user.email'
        indexes :file_name, :analyzer => :keyword
        indexes :description, :analyzer => :snowball
        indexes :tags, :analyzer => :keyword, :as => 'tag_list'
        indexes :created_at, :type => :date, :include_in_all => false
        indexes :taxon, :analyzer => :taxon_analyzer, :as => 'create_taxon'
      end
    end
  end

  module ClassMethods
    def search_with_params(params)
      self.search params[:q], sort: [ { created_at: { order: :desc } }]
    end
  end
end
