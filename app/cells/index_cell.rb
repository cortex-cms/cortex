class IndexCell < Cell::ViewModel
  property :data

  def index
    render
  end

  def table_headers
    render
  end

  def table_body
    render
  end

  private

  def render_table_header(column_data)
    column_data[:name]
  end

  def content_item_title(content_item)
    content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text']
  end

  def content_item_thumb_url(content_item)
    content_item.field_items.find { |field_item| field_item.field.name == 'Asset' }.data['asset']['style_urls']['mini']
  end
end
