module API::V1
  module Entities
    class PostBasic < Grape::Entity
      expose :seo_preview,
             :primary_category_id, :primary_industry_id

      expose :id, documentation: {type: "Integer", desc: "Post ID", required: true}
      expose :title, documentation:  {desc: "Post Title", type: "String" , required: true}
      expose :author, documentation: {desc: "Author", type: "String", required: true}
      expose :type, documentation: {desc: "Post Type", type: "String", enum: ["ArticlePost", "VideoPost", "InfographicPost", "PromoPost"], required: true}
      expose :draft, documentation: {desc: "Draft status", type: "Boolean"}
      expose :comment_count, documentation: {desc: "Number of comments", type: "Integer"}
      expose :body, documentation: {desc: "Body of the post", type: "String"}
      expose :short_description, documentation: {desc: "Short description of the post", type: "String", required: true}
      expose :job_phase, documentation: {desc: "Job Phase", type: "String", enum: ["discovery", "find_the_job", "get_the_job", "on_the_job"], required: true}
      expose :slug, documentation: {desc: "Slug", type: "String", required: true}
      expose :created_at, documentation: { type: 'dateTime', desc: "Created Date"}
      expose :updated_at, documentation: { type: 'dateTime', desc: "Last Updated Date"}
      expose :published_at, documentation: { type: 'dateTime', desc: "Publish Date"}
      expose :expired_at, documentation: { type: 'dateTime', desc: "Expiration Date"}
      expose :copyright_owner, documentation: { type: "String", desc: "Copyright Owner"}
      expose :notes, documentation: {type: "String", desc: "Notes about this post"}
      expose :seo_title, documentation: {type: "String", desc: "SEO-specific title for this post"}
      expose :seo_description, documentation: {type: "String", desc: "SEO-specific description for this post"}
      expose :primary_category_id, documentation: {type: "Integer", desc: "Primary Category ID"}
      expose :primary_industry_id, documentation: {type: "Integer", desc: "Primary Industry ID"}

      # This runtime exposure is necessary to correctly resolve the enum value
      expose(:display) do |post|
        post.display
      end

      expose :categories, using: 'Entities::Category', documentation: {type: 'Category', is_array: true, desc: "Categories"}
      expose :featured_media, using: 'Entities::MediaBasic', documentation: {type: "Media", is_array: false, desc: "Featured Media for this post"}
      expose :tile_media, using: 'Entities::MediaBasic', documentation: {type: "Media", is_array: false, desc: "Tile Media for this post"}
      expose :industries, using: 'Entities::Occupation', documentation: {type: "Industry", is_array: true, desc: "Industries"}

      expose :destination_url, :call_to_action,
             if: lambda { |post, _| post.type == 'PromoPost' }
    end
  end
end
