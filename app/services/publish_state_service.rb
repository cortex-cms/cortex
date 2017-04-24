class PublishStateService < ApplicationController
  def perform(sorted_field_items, content_item)
    @sorted_field_items = sorted_field_items
    @content_item = content_item

    Rails.cache.fetch("PublishStateService/#{content_item.id}", expires_in: 30.minutes) do
      active_state
    end
  end

  def self.clear(content_item)
    Rails.cache.delete("PublishStateService/#{content_item.id}")
  end

  private

  def active_state
    @sorted_field_items.each do |field_item|
      if DateTime.now > DateTime.parse(field_item.data["timestamp"])
        return field_item.field.metadata["state"]
        break
      end
    end

    return @content_item.state.titleize
  end
end
