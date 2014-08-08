require 'ostruct'

module API
  module V1
    module Helpers
      module PaginationHelper
        def page
          @page ||= params[:page] || 1
        end

        def per_page
          @per_page ||= params[:per_page] || Kaminari.config.default_per_page
        end

        def entity_page(scope, entity, **options)
          {
            paging: {
              limit_value:  scope.limit_value,
              total_count:  scope.total_count,
              current_page: scope.current_page,
              count:        scope.count
            },
            items: entity.represent(scope, options).to_json
          }
        end
      end
    end
  end
end
