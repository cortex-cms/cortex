module API::V1
  module Entities
    class MediaBasic < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "Media ID", required: true }
      expose :name, documentation: { type: "String", desc: "Media Name", required: true }
      expose :alt, documentation: { type: "String", desc: "Alt-text for Media" }
      expose :taxon, documentation: { type: "String", desc: "Taxon string" }
      expose :dimensions, documentation: { type: "Array", desc: "Array of [Width, Height]" }
      expose :url, documentation: { type: "String", desc: "URL of Media" }
      expose :type, documentation: { type: "String", desc: "Media Type" }
      expose :attachment, using: 'Entities::MediaThumbnails', as: :thumbs, if: lambda { |media, _| media.can_thumb }, documentation: { type: "MediaThumbnail", desc: "Thumbnails of the media"}

      expose :video_id, if: lambda { |media, _| media.content_type == 'youtube' }, documentation: { type: "String", desc: "Youtube Video ID"}
    end
  end
end
