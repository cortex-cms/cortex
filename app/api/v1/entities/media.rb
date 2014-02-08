#require_relative 'media_thumbnails'

module API::V1
  module Entities
    class Media < Grape::Entity
      expose :id, :name, :created_at, :dimensions, :updated_at, :deactive_at, :deleted_at, :taxon, :general_type, :tags,
             :description, :alt, :active

      # Aliases
      expose :attachment_file_size, as: :file_name
      expose :attachment_file_name, as: :file_name
      expose :attachment_content_type, as: :content_type
      expose :consumed?, as: :consumed

      expose(:attachment_url) { |media| media.attachment.url }
      expose :user, with: 'Entities::UserBasic', as: :creator
      expose :attachment, with: 'Entities::MediaThumbnails', as: :thumbs, if: lambda { |media, _| media.can_thumb }
    end
  end
end
