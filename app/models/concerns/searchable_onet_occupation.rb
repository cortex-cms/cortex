module SearchableOnetOccupation
  extend ActiveSupport::Concern

  included do
    include Searchable

    mapping do
      indexes :id, :type => :integer, :index => :not_analyzed
      indexes :soc, :analyzer => 'keyword'
      indexes :title, :analyzer => 'snowball'
      indexes :description, :analyzer => 'snowball'
    end
  end

  module ClassMethods
    def search_with_params(params)
      query = self.query_massage(params[:q])
      self.search query
    end
  end
end
