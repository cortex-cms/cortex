module API::V1
  module Helpers
    module PaginationHelper
      def page
        @page ||= params[:page] || 1
      end

      def per_page
        @per_page ||= params[:per_page] || Kaminari.config.default_per_page
      end
    end
  end
end
