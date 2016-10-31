module RssHelper
  def rss_content_type
    @content_type = ContentType.find_by_name(params[:content_type_name]) || ContentType.new
  end

  def field_value(content_item, field_id)
    field = content_item.field_items.find_by_field_id(field_id)
    truncate(field.data.values.join("")) unless field.nil?
  end

  private

  def truncate(str)
    if @config['summarize']
      str.length > 50 ? str.slice(0..50) + "..." : str
    else
      str
    end
  end
end
