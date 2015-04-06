class BulkCreateMediaJob < ActiveJob::Base
  queue_as :default

  def perform(bulk_job)
  end
end
