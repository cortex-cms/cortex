require_relative 'media_basic'

module API::V1
  module Entities
    class Media < MediaBasic
      expose :created_at, documentation: { type: 'dateTime', desc: "Created Date"}
      expose :updated_at, documentation: { type: 'dateTime', desc: "Updated Date"}
      expose :deactive_at, documentation: { type: 'dateTime', desc: "Deactivate Date"}
      expose :deleted_at, documentation: { type: 'dateTime', desc: "Deleted Date"}
      expose :tags
      expose :description, documentation: { type: "String", desc: "Description of the media" }
      expose :active, documentation: { type: "Boolean", desc: "Media active" }

      # Aliases
      expose :attachment_file_size, as: :attachment_size, documentation: { type: "Integer", desc: "Filesize in bytes" }
      expose :attachment_file_name, as: :attachment_name, documentation: { type: "String", desc: "Filename" }
      expose :attachment_content_type, as: :attachment_content_type, documentation: { type: "String", desc: "Attachment Mime Type" }
      expose :content_type, as: :type, documentation: { type: "String", desc: "Media type" }
      expose :consumed?, as: :consumed, documentation: { type: "Boolean", desc: "Is the media consumed?" }

      expose :user, with: 'Entities::UserBasic', as: :creator, documentation: { type: "User", desc: "Owner" }

      expose :duration, :title, :authors, :video_description,
             if: lambda { |media, _| media.content_type == 'youtube' }
    end
  end
end
