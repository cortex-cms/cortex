module API::V1
  module Entities
    class Tag < Grape::Entity
      expose :id, :name, :count
    end
  end
end
