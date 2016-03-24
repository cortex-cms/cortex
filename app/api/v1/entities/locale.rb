module V1
  module Entities
    class Locale < Grape::Entity
      expose :id, documentation: {type: 'Integer', desc: 'Locale ID', required: true}
      expose :name, documentation:  {type: 'String', desc: 'Locale Name', required: true}
      expose :yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Locale Data as YAML'}
      expose :json, documentation:  {type: 'Hash', is_array: true, desc: 'Locale Data as JSON'}
      expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
      expose :updated_at, documentation: { type: 'dateTime', desc: 'Last Updated Date'}

      expose :user, with: 'V1::Entities::User', as: :creator, documentation: { type: 'User', desc: 'Owner' }
    end
  end
end
