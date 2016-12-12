module PopupHelper
  def media_content_type
    @media_content_type ||= ContentType.find_by_name("Media")
  end

  def media_index
    @media_index ||= IndexDecoratorService.new(content_type: media_content_type)
  end
end
