require_relative 'category'

module API::V1
  module Entities
    class CategoryWithChildren < Category
      expose :children, with: CategoryWithChildren
    end
  end
end
