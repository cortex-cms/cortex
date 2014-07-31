module API
  module V1
    module Entities
      class Media < Grape::Entity
        expose :id, documentation: { type: "Integer", desc: "Media ID", required: true }
        expose :name, documentation: { type: "String", desc: "Media Name", required: true }
        expose :alt, documentation: { type: "String", desc: "Alt-text for Media" }
        expose :taxon, documentation: { type: "String", desc: "Taxon string" }
        expose :dimensions, documentation: { type: "Array", desc: "Array of [Width, Height]" }
        expose :url, documentation: { type: "String", desc: "URL of Media" }
        expose :type, documentation: { type: "String", desc: "Media Type" }
        expose :created_at, documentation: { type: 'dateTime', desc: "Created Date"}
        expose :updated_at, documentation: { type: 'dateTime', desc: "Updated Date"}
        expose :attachment_file_name, documentation: { type: "String", desc: "Filename" }
        expose :content_type, documentation: { type: "String", desc: "Media type" }

        ## Thumbnails
        expose :attachment, using: 'Entities::MediaThumbnails', as: :thumbs, if: lambda { |media, _| media.can_thumb }, documentation: { type: "MediaThumbnails", desc: "Thumbnails of the media"}

        ## Youtube Specific
        expose :duration, :title, :authors, :video_description,
               if: lambda { |media, _| media.content_type == 'youtube' }
        expose :video_id, if: lambda { |media, _| media.content_type == 'youtube' }, documentation: { type: "String", desc: "Youtube Video ID"}

        # Full Only
        with_options if: { full: true } do
          expose :deactive_at, documentation: { type: 'dateTime', desc: "Deactivate Date"}
          expose :deleted_at, documentation: { type: 'dateTime', desc: "Deleted Date"}
          expose :tags
          expose :description, documentation: { type: "String", desc: "Description of the media" }
          expose :active, documentation: { type: "Boolean", desc: "Media active" }

          ## Aliases
          expose :attachment_file_size, documentation: { type: "Integer", desc: "Filesize in bytes" }
          expose :attachment_content_type, documentation: { type: "String", desc: "Attachment Mime Type" }
          expose :consumed?, as: :consumed, documentation: { type: "Boolean", desc: "Is the media consumed?" }

          expose :user, with: 'Entities::User', as: :creator, documentation: { type: "User", desc: "Owner" }
        end
      end
    end
  end
end
