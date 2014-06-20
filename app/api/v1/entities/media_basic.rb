module API::V1
  module Entities
    class MediaBasic < Grape::Entity
      expose :id, :name, :alt, :taxon, :dimensions, :url, :type
      expose :attachment, with: 'Entities::MediaThumbnails', as: :thumbs, if: lambda { |media, _| media.can_thumb }

      expose :video_id, if: lambda { |media, _| media.content_type == 'youtube' }
    end
  end
end
