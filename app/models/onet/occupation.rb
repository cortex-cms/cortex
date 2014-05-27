module Onet
  class Occupation < ActiveRecord::Base
    include Tire::Model::Search
    include Tire::Model::Callbacks

    has_one :post

    mapping do
      indexes :id,                :index => :not_analyzed
      indexes :soc,               :analyzer => 'keyword'
      indexes :title,             :analyzer => 'snowball'
      indexes :description,       :analyzer => 'snowball'
    end

    scope :industries, -> {
      where('soc like ?', '%0000%')
    }
  end
end

