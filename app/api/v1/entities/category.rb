module API::V1
  module Entities
    class Category < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "Category ID" }
      expose :name, documentation: { type: "String", desc: "Category Name"}
    end
  end
end
