module API
  module V1
    module Entities
      class Snippet < Grape::Entity
        expose :id, documentation: { type: 'Integer', desc: 'Snippet ID', required: true }
        expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
        expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated Date'}
        expose :document, with: 'Entities::Document', documentation: {type: 'Document', desc: 'Associated Document'}
      end
    end
  end
end
