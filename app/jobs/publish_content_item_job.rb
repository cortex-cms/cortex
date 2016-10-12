class PublishContentItemJob < ActiveJob::Base
  queue_as :default

  def perform(content_item_id)
    content_item = ContentItem.find(content_item_id)
    content_item.publish!
  end
end
