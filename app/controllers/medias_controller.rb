class MediasController < AdminController
  add_breadcrumb 'Media', :medias_path

  def index
  end

  def show
    add_breadcrumb 'Name goes here', media_path
  end
end
