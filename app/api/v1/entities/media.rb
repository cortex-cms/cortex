require_relative 'media_basic'

module API::V1
  module Entities
    class Media < MediaBasic
      expose :created_at, :updated_at, :deactive_at, :deleted_at, :tags, :description, :active

      # Aliases
      expose :attachment_file_size, as: :attachment_size
      expose :attachment_file_name, as: :attachment_name
      expose :attachment_content_type, as: :attachment_content_type
      expose :content_type, as: :type
      expose :consumed?, as: :consumed

      expose :user, with: 'Entities::UserBasic', as: :creator

      expose :duration, :video_id, :title, :authors, :video_description,
             if: lambda { |media, _| media.content_type == 'youtube' }
    end
  end
end
