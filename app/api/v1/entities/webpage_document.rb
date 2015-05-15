module API
  module V1
    module Entities
      class WebpageDocument < Grape::Entity
        expose :id, documentation: { type: 'Integer', desc: 'Webpage Document ID', required: true }
        expose :user, with: 'Entities::User', as: :creator, documentation: { type: 'User', desc: 'Owner' }
        expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
        expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated Date'}
        represent :document, with: 'Entities::Document', documentation: {type: 'Document', desc: 'Associated Document'}
      end
    end
  end
end
