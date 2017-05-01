class PublishStateService < ApplicationService
  def content_item_state(content_item)
    @content_item = content_item

    active_state
  end

  private

  def active_state
    sorted_field_items.each do |field_item|
      if !field_item.data['timestamp'].blank? && DateTime.now > DateTime.parse(field_item.data["timestamp"])
        return field_item.field.metadata["state"]
        break
      end
    end

    return @content_item.state.titleize
  end

  def sorted_field_items
    @sorted_field_items ||= @content_item.field_items.select { |fi| fi.field.field_type_instance.is_a?(DateTimeFieldType) && !fi.field.metadata["state"].nil? }.sort_by{ |a| a.data["timestamp"] }.reverse
  end
end
