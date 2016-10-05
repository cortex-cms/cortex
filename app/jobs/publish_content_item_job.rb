class PublishContentItemJob < ActiveJob::Base
  def perform(content_item)
    content_item.publish!
  end
end
