class PublishStateService < ApplicationService
  def content_item_state(sorted_field_items, content_item)
    @sorted_field_items = sorted_field_items
    @content_item = content_item

    active_state
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
