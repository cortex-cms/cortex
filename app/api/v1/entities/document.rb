module API
  module V1
    module Entities
      class Document < Grape::Entity
        expose :id, documentation: { type: 'Integer', desc: 'Document ID', required: true }
        expose :name, documentation: { type: 'String', desc: 'Document Name', required: true }
        expose :body, documentation: { type: 'String', desc: 'Body Text', required: true }
        expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
        expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated Date'}
      end
    end
  end
end
