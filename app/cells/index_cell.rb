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

  def asset_field_item(content_item)
    content_item.field_items.find { |field_item| field_item.field.name == 'Asset' }
  end

  def content_item_title(content_item)
    content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text']
  end

  def content_item_thumb_url(content_item)
    asset_field_item(content_item).data['asset']['style_urls']['mini']
  end

  def content_item_asset_url(content_item)
    asset_field_item(content_item).data['asset']['url']
  end

  def content_item_asset_type(content_item)
    asset_field_item(content_item).data['asset']['content_type']
  end

  def content_item_asset_alt_text(content_item)
    content_item.field_items.find { |field_item| field_item.field.name == 'Alt Tag' }.data['text']
  end
end
