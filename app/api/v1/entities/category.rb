module API::V1
  module Entities
    class Category < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "Category ID" }
      expose :name, documentation: { type: "String", desc: "Category Name"}
      expose :children, if: lambda { |instance, options| options[:children] }, documentation: { type: "Category", is_array: true, desc: "Child Categories" }
    end
  end
end
