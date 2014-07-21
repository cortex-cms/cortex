module API::V1
  module Helpers
    module SharedParams
      extend Grape::API::Helpers

      params :pagination do
        optional :page, type: Integer, default: 1, desc: "Page index"
        optional :per_page, type: Integer, default: 10, desc: "Results per page"
      end

      params :search do
        optional :q, type: String, desc: "Query string"
      end

      params :post_metadata do
        optional :categories, type: "String", desc: "Categories"
        optional :industries, type: "String", desc: "Industries"
        optional :job_phase, type: "String", desc: "Job Phase"
        optional :type, type: "String", desc: "Post Type"
      end
    end
  end
end
