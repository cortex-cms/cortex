module RssHelper
  def rss_content_type
    @content_type = ContentType.find_by_name(params[:content_type_name]) || ContentType.new
  end

  def field_value(content_item, field_id)
    field = content_item.field_items.find_by_field_id(field_id)
    field.data.values.join("") unless field.nil?
  end

  def plugin_value(content_item, value_hash)
    field = content_item.field_items.find_by_field_id(value_hash['data']['field_id'])
    cell(value_hash['class_name'], field, display: value_hash['display'], config: value_hash['config']).(value_hash['render_method'])
  end

  def method_value(content_item, method)
    content_item.send(method).to_s
  end

  def parse_data(key, value_hash, content_item)
    if value_hash.keys.include?("field")
      field_value(content_item, value_hash["field"])
    elsif value_hash.include?("plugin")
      plugin_value(content_item, value_hash["plugin"])
    elsif value_hash.include?("method")
      method_value(content_item, value_hash["method"])
    end
  end
end
