module API::V1
  module Entities
    class Media < Grape::Entity
      expose :id, :name, :created_at, :dimensions, :updated_at, :deactive_at, :deleted_at, :taxon,
             :tags, :description, :alt, :active, :url

      # Aliases
      expose :attachment_file_size, as: :attachment_size
      expose :attachment_file_name, as: :attachment_name
      expose :attachment_content_type, as: :attachment_content_type
      expose :content_type, as: :type
      expose :consumed?, as: :consumed

      expose :user, with: 'Entities::UserBasic', as: :creator
      expose :attachment, with: 'Entities::MediaThumbnails', as: :thumbs, if: lambda { |media| media.can_thumb }
      expose :meta, if: { content_type: 'youtube' }, with: 'YoutubeMeta'
    end

    class YoutubeMeta < Grape::Entity
      expose :video_id, :duration, :duration, :video_id, :title, :author, :video_description
    end
  end
end
