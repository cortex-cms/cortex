require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Categories < Grape::API
        resource :categories do

          desc 'Show all categories', { entity: Entities::Category, nickname: "showAllCategories" }
          params do
            optional :depth, default: 1, type: Integer, desc: "Minimum category depth"
          end
          get do
            authorize! :view, Category
            present Category.where("depth >= ?", params[:depth]), with: Entities::Category
          end

          desc 'Show category hierarchy', { entity: Entities::Category, nickname: "showCategoryHierarchy" }
          get :hierarchy do
            authorize! :view, Category
            if params[:roots_only] == 'false'
              present Category.all, with: Entities::Category
            else
              present Category.roots, with: Entities::Category, children: true
            end
          end
        end
      end
    end
  end
end
