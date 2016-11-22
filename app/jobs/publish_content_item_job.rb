class PublishContentItemJob < ApplicationJob
  queue_as :default

  def perform(content_item)
    content_item.publish!
  end
end
