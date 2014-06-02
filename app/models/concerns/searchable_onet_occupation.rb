module SearchableOnetOccupation
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      indexes :id,          :index => :not_analyzed
      indexes :soc,         :analyzer => 'keyword'
      indexes :title,       :analyzer => 'snowball'
      indexes :description, :analyzer => 'snowball'
    end
  end

  module ClassMethods
    def search_with_params(params)
      self.search params[:q], sort: [ { created_at: { order: :desc } }]
    end
  end
end
