module V1
  module Helpers
    module SharedParamsHelper
      extend Grape::API::Helpers

      params :pagination do
        optional :page, type: Integer, default: 1, desc: 'Page index'
        optional :per_page, type: Integer, default: 10, desc: 'Results per page'
      end

      params :search do
        optional :q, type: String, desc: 'Query string'
      end
    end
  end
end
