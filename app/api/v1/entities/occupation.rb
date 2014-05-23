module API::V1
  module Entities
    class Occupation < Grape::Entity
      expose :soc, :title, :description
    end
  end
end
