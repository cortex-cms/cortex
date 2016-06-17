class ContentTypesController < ApplicationController
  add_breadcrumb 'Custom Content', :content_types_path

  def index
    @content_types = ContentType.all
  end

  def new

  end

  def create

  end
end
