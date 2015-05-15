module API
  module V1
    module Entities
      class Webpage < Grape::Entity
        expose :id, documentation: { type: 'Integer', desc: 'Webpage ID', required: true }
        expose :user, with: 'Entities::User', as: :creator, documentation: { type: 'User', desc: 'Owner' }
        expose :name, documentation: { type: 'String', desc: 'Webpage Name', required: true }
        expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
        expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated Date'}
        expose :url, documentation: { type: 'String', desc: 'URL of Webpage' }
        expose :tile_thumbnail, documentation: {desc: 'URL Thumbnail - Tile Size'} do |thumbnail| thumbnail.url(:tile) end
        represent :webpage_documents, with: 'Entities::WebpageDocument', documentation: {type: 'WebpageDocument', is_array: true, desc: 'All associated WebpageDocuments for this Webpage'}
      end
    end
  end
end
