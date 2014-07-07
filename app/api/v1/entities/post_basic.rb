module API::V1
  module Entities
    class PostBasic < Grape::Entity
      expose :id, :copyright_owner, :author, :title, :type, :published_at, :expired_at, :deleted_at,
             :created_at, :updated_at, :draft, :comment_count, :body, :short_description,
             :job_phase, :notes, :seo_title, :seo_description, :seo_preview, :slug,
             :primary_category_id, :primary_industry_id

      # This runtime exposure is necessary to correctly resolve the enum value
      expose(:display) do |post|
        post.display
      end

      expose :categories, with: 'Entities::Category'
      expose :featured_media, with: 'Entities::MediaBasic'
      expose :tile_media, with: 'Entities::MediaBasic'
      expose :industries, with: 'Entities::Occupation'

      expose :destination_url, if: lambda { |post, _| post.post_type == 'Promo' }
      expose :call_to_action, if: lambda { |post, _| post.post_type == 'Promo' }

    end
  end
end
