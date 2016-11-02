module RssHelper
  def rss_content_type
    @content_type = ContentType.find_by_name(params[:content_type_name]) || ContentType.new
  end

  def rss_decorator
    @rss_decorator ||= rss_content_type.rss_decorator.data
  end

  def field_value(content_item, field_id)
    field_item = content_item.field_items.find_by_field_id(field_id)
    field_item.data.values.join unless field_item.nil?
  end

  def plugin_value(content_item, tag_data_hash)
    field_item = content_item.field_items.find_by_field_id(tag_data_hash['data']['field_id'])
    cell(tag_data_hash['class_name'], field_item, display: tag_data_hash['display'], config: tag_data_hash['config']).(tag_data_hash['render_method'])
  end

  def method_value(content_item, method)
    content_item(method["name"], *method["args"])
  end

  def get_tag_data(tag_data_hash, content_item)
    if tag_data_hash.keys.include?("field")
      field_value(content_item, tag_data_hash["field"])
    elsif tag_data_hash.include?("plugin")
      plugin_value(content_item, tag_data_hash["plugin"])
    elsif tag_data_hash.include?("method")
      method_value(content_item, tag_data_hash["method"])
    end
  end
end
