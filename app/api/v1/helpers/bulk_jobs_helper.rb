module API
  module V1
    module Helpers
      module BulkJobsHelper
        def bulk_job
          @bulk_job ||= ::BulkJob.find_by_id(params[:id])
        end

        def bulk_job!
          bulk_job || not_found!
        end
      end
    end
  end
end
