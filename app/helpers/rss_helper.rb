module RssHelper
  include ActiveSupport::Inflector

  def rss_content_type
    @content_type = ContentType.find_by_name(titleize(params[:content_type_name])) || ContentType.new
  end

  def rss_decorator
    @rss_decorator ||= rss_content_type.rss_decorator.data
  end

  def channel_spec
    @channel_spec ||= CortexRssSpec::Channel.feed
  end

  def item_spec
    @item_spec ||= CortexRssSpec::Item.feed
  end

  def key_name(key)
    key.split(":").first
  end

  def tag_data(tag_data_hash, rss_content_item)
    if tag_data_hash.keys.include?("string")
      tag_data_hash["string"]
    elsif tag_data_hash.keys.include?("field")
      field_item_data(tag_data_hash["field"], rss_content_item, tag_data_hash)
    elsif tag_data_hash.keys.include?("method")
      method_data(tag_data_hash["method"], rss_content_item)
    elsif tag_data_hash.keys.include?("media")
      media_data(tag_data_hash["media"], rss_content_item)
    end
  end

  private

  def field_item_data(field_id, rss_content_item, tag_data_hash)
    values = rss_content_item.field_items.find_by_field_id(field_id).data.values
    tag_data_hash.has_key?("multiple") ? (values.join(tag_data_hash["multiple"])) : (values.join)
  end

  def method_data(method_hash, rss_content_item)
    rss_content_item.send(method_hash["name"], *method_hash["args"])
  end

  def media_data(media_hash, rss_content_item)
    linked_field_item = rss_content_item.field_items.find_by_field_id(media_hash["field"])

    field_name = linked_field_item.field.metadata["field_name"]
    asset_content_item_id = linked_field_item.data["content_item_id"]
    field_item = Field.find_by_name(field_name).field_items.find { |field_item| field_item.content_item_id == asset_content_item_id }

    if field_item.nil?
      {}
    else
      asset_data = field_item.data['asset']['versions']['rss']

      {
        "url": asset_data["url"],
        "type": asset_data["mime_type"],
        "medium": media_hash["medium"],
        "width": media_hash["width"] || asset_data["dimensions"]["width"],
        "height": media_hash["height"] || asset_data["dimensions"]["height"]
      }
    end
  end
end
