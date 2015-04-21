module API
  module V1
    module Entities
      class BulkJob < Grape::Entity
        expose :id, documentation: { type: 'UUID', desc: 'Bulk upload job UUID', required: true }
        expose :content_type, documentation: { type: 'String', desc: 'Type of content being processed. Types supported: Media (/media/bulk_job), Users (/users/bulk_job)' }
        expose :status, documentation: { type: 'String', desc: 'Bulk upload job status' }
        expose :log, documentation: { type: 'Text', is_array: true, desc: 'Full log as Array for bulk upload job' }
        expose :created_at, documentation: { type: 'dateTime', desc: 'Created date'}
        expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated date'}
        expose :user, with: 'Entities::User', as: :creator, documentation: { type: 'User', desc: 'Owner' }
        expose :metadata, documentation: { type: 'String', desc: 'Bulk metadata (CSV) URL', required: true }
        expose :assets, documentation: { type: 'String', desc: 'Assets to be uploaded (ZIP) URL' }, if: lambda { |bulkJob, _| bulkJob.assets_file_name.present? }
      end
    end
  end
end
