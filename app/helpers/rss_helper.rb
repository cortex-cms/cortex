module RssHelper
  def content_type
    @content_type = ContentType.find_by_name(params[:content_type_name]) || ContentType.new
  end
end
