module V1
  module Resources
    class BulkJobs < Grape::API
      resource :bulk_jobs do
        include Grape::Kaminari
        helpers Helpers::BulkJobsHelper

        paginate per_page: 25

        desc 'Show all bulk jobs', { entity: V1::Entities::BulkJob, nickname: 'showAllBulkJobs' }
        get do
          authorize! :view, ::BulkJob
          require_scope! :'view:bulk_jobs'

          @bulk_job = ::BulkJob.order(created_at: :desc)

          V1::Entities::BulkJob.represent paginate(@bulk_job)
        end

        desc 'Get bulk job', { entity: V1::Entities::BulkJob, nickname: 'showBulkJob' }
        get ':id' do
          require_scope! :'view:bulk_jobs'
          authorize! :view, bulk_job!

          present bulk_job, with: V1::Entities::BulkJob
        end
      end
    end
  end
end
