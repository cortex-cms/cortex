module V1
  module Entities
    class Localization < Grape::Entity
      expose :id, documentation: {type: 'Integer', desc: 'Localization ID', required: true}
      expose :name, documentation:  {type: 'String', desc: 'Localization Name', required: true}
      expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
      expose :updated_at, documentation: { type: 'dateTime', desc: 'Last Updated Date'}
      expose :available_locales, documentation:  {type: 'String', is_array: true, desc: 'Available Locales'}

      expose :user, with: 'V1::Entities::User', as: :creator, documentation: { type: 'User', desc: 'Owner' }
      expose :locales, using: 'V1::Entities::Locale', documentation: {type: 'Locale', is_array: true, desc: 'Locales'}
    end
  end
end
