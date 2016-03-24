module V1
  module Resources
    class Categories < Grape::API
      resource :categories do
        desc 'Show all categories', { entity: ::V1::Entities::Category, nickname: "showAllCategories" }
        params do
          optional :depth, default: 1, type: Integer, desc: "Minimum category depth"
        end
        get do
          authorize! :view, Category
          present Category.where("depth >= ?", params[:depth]), with: ::V1::Entities::Category
        end

        desc 'Show category hierarchy', { entity: ::V1::Entities::Category, nickname: "showCategoryHierarchy" }
        get :hierarchy do
          authorize! :view, Category
          if params[:roots_only] == 'false'
            present Category.all, with: ::V1::Entities::Category
          else
            present Category.roots, with: ::V1::Entities::Category, children: true
          end
        end
      end
    end
  end
end
