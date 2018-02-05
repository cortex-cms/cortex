require_dependency 'cortex/application_controller'

module Cortex
  class ContentTypesController < AdminController
    add_breadcrumb 'Content Types', :content_types_path

    def index
      @content_types = Cortex::ContentType.all
    end

    def new

    end

    def create

    end
  end
end
