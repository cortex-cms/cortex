module API
  module V1
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
          optional :categories, type: String, desc: "Categories"
          optional :industries, type: String, desc: "Industries"
          optional :job_phase, type: String, desc: "Job Phase"
          optional :post_type, type: String, desc: "Post Type"
          optional :author, type: String, desc: "Post Author"
        end

        params :post_associations do
          optional :featured_media_id, type: Integer, desc: "Featured Media ID"
          optional :tile_media_id, type: Integer, desc: "Tile Media ID"
          optional :author_id, type: Integer, desc: "Author ID"
        end
      end
    end
  end
end
