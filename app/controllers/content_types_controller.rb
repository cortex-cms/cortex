class ContentTypesController < AdminController
  add_breadcrumb 'Content Types', :content_types_path

  def index
    @content_types = ContentType.all
  end

  def new

  end

  def create

  end
end
