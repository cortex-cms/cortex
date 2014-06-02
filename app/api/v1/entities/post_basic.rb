module API::V1
  module Entities
    class PostBasic < Grape::Entity
      expose :id, :copyright_owner, :author, :title, :type, :published_at, :expired_at, :deleted_at, :created_at,
             :updated_at, :draft, :comment_count, :body, :short_description, :job_phase, :notes,
             :seo_title, :seo_description, :seo_preview, :slug

      expose(:display) do |post|
        post.display
      end

      expose :categories, with: 'Entities::Category'
      expose :featured_media, with: 'Entities::MediaFeatured'
      expose :industry, with: 'Entities::Occupation'
    end
  end
end
