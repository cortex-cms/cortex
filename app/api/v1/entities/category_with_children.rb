require_relative 'category'

module API::V1
  module Entities
    class CategoryWithChildren < Category
      expose :children, using: CategoryWithChildren, documentation: { type: "Category", is_array: true, desc: "Categories"}
    end
  end
end
