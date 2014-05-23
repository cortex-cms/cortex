class Onet::Occupation < ActiveRecord::Base
  include Tire::Model::Search

  mapping do
    indexes :id,                :index => :not_analyzed
    indexes :soc,               :analyzer => 'keyword'
    indexes :title,             :analyzer => 'snowball'
    indexes :description,       :analyzer => 'snowball'
  end

  scope :industries, -> {
    # Search occupations for job families. Broken...
  }
end
