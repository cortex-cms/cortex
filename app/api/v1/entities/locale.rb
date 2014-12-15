module API
  module V1
    module Entities
      class Locale < Grape::Entity
        expose :id, documentation: {type: 'Integer', desc: 'Locale ID', required: true}
        expose :name, documentation:  {type: 'String', desc: 'Locale Name', required: true}
        expose :json, documentation:  {type: 'Hash', is_array: true, desc: 'Locale Data'}

        expose :user, with: 'Entities::User', as: :creator, documentation: { type: 'User', desc: 'Owner' }
      end
    end
  end
end
