module API::V1
  module Entities
    class MediaBasic < Grape::Entity
      expose :id, :name, :alt, :taxon, :dimensions
      expose(:attachment_url) { |media| media.attachment.url }
      expose :attachment, with: 'Entities::MediaThumbnails', as: :thumbs, if: lambda { |media, _| media.can_thumb }
    end
  end
end
