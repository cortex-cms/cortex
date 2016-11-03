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
      field_item_data(tag_data_hash["field"], rss_content_item)
    elsif tag_data_hash.keys.include?("method")
      method_data(tag_data_hash["method"], rss_content_item)
    else
      ""
    end
  end

  private

  def field_item_data(field_id, rss_content_item)
    rss_content_item.field_items.find_by_field_id(field_id).data.values.join
  end

  def method_data(method_hash, rss_content_item)
    rss_content_item.send(method_hash["name"], *method_hash["args"])
  end
end
