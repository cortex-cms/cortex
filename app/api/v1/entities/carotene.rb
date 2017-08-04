module V1
  module Entities
    class Carotene < Grape::Entity
      expose :id, documentation: { type: 'UUID', desc: 'Carotene ID', required: true }
      expose :title, documentation: { type: 'String', desc: 'Carotene Title', required: true }
      expose :code, documentation: { type: 'String', desc: 'Carotene Code', required: true }
      expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
      expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated Date'}
    end
  end
end
