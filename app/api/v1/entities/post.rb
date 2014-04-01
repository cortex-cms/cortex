module API::V1
  module Entities
    class Post < Grape::Entity
      expose :id, :copyright_owner, :author, :title, :type, :published_at, :expired_at, :deleted_at, :created_at,
             :updated_at, :draft, :comment_count, :body, :short_description, :job_phase, :featured_image_url,
             :notes, :seo_title, :seo_description, :seo_preview, :media

      expose(:display) do |post|
        post.display
      end

      expose(:tags) { |post| post.tag_list.join(', ') }
      expose :user, with: 'Entities::UserBasic'
      expose :categories, with: 'Entities::Category'
    end
  end
end
