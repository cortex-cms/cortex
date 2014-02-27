#require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Categories < Grape::API

      resource :categories do

        desc 'Show all categories'
        get do
          authorize! :view, Category
          present Category.all, with: Entities::Category
        end

        desc 'Show category hierarchy'
        get :hierarchy do
          authorize! :view, Category
          if params[:roots_only] == 'false'
            present Category.all, with: Entities::Category
          else
            present Category.roots, with: Entities::CategoryWithChildren
          end
        end
      end
    end
  end
end
