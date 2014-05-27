module API::V1
  module Entities
    class Occupation < Grape::Entity
      expose :id, :soc, :title, :description
    end
  end
end
