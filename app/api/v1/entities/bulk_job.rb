module API
  module V1
    module Entities
      class BulkJob < Grape::Entity
        expose :id, documentation: { type: 'UUID', desc: 'Bulk upload job UUID', required: true }
        expose :type, documentation: { type: 'String', desc: 'Type of content being processed', required: true }
        expose :status, documentation: { type: 'String', desc: 'Bulk upload job status' }
        expose :log, documentation: { type: 'Text', desc: 'Bulk upload job full log' }
        expose :created_at, documentation: { type: 'dateTime', desc: 'Created date'}
        expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated date'}
        expose :user, with: 'Entities::User', as: :creator, documentation: { type: 'User', desc: 'Owner' }
        expose :metadata_url, documentation: { type: 'String', desc: 'Bulk Media metadata (CSV) URL' }
        expose :assets_url, documentation: { type: 'String', desc: 'Assets to be uploaded (ZIP) URL' }
      end
    end
  end
end
