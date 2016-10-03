module PublishStateManager
  def self.publish_valid_items
    scheduled_items = ContentItem.select{ |content_item| content_item.state == "scheduled" }

    scheduled_items.each do |item|
      date_id = item.content_type.fields.find{ |field| field.name == "Publish Date" }.id
      date = item.field_items.find{ |field_item| field_item.field.id == date_id }.data["timestamp"]

      item.publish! if Date.parse(date) == Date.today
    end
  end
end
