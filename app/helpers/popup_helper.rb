module PopupHelper
  # TODO: This needs to be in a plugin

  def media_content_type
    @media_content_type ||= current_user.active_tenant.search_up_organization_for(ContentType, :name, 'Media').first
  end

  def media_content_items
    @media_content_items ||= media_content_type.content_items
  end

  def media_asset_field
    @media_asset_field ||= media_content_type.fields.find_by_name('Asset')
  end

  def media_image_content_items
    @media_image_content_items ||= media_content_items.select do |content_item|
      MimeMagic.new(content_item.field_items.find_by_field_id(media_asset_field).data['asset']['versions']['original']['mime_type']).mediatype == 'image'
    end
  end

  def media_index
    @media_index ||= IndexDecoratorService.new(content_type: media_content_type)
  end
end
