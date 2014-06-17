require_relative 'media_basic'

module API::V1
  module Entities
    class Media < MediaBasic
      expose :created_at, :updated_at, :deactive_at, :deleted_at, :general_type, :tags, :description, :active

      # Aliases
      expose :attachment_file_size, as: :file_name
      expose :attachment_file_name, as: :file_name
      expose :attachment_content_type, as: :content_type
      expose :consumed?, as: :consumed

      expose :user, with: 'Entities::UserBasic', as: :creator
    end
  end
end
