class PublishContentItemJob < ActiveJob::Base
  queue_as :default

  def perform(content_item)
    content_item.publish!
  end
end
