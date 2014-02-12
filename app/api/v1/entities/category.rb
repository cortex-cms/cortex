module API::V1
  module Entities
    class Category < Grape::Entity
      expose :id, :name
    end
  end
end
