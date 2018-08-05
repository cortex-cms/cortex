require_dependency 'cortex/application_controller'

module Cortex
  class ContentItemsController < AdminController
    include Cortex::Decoratable
    include Cortex::ContentItemHelper
    include Cortex::PopupHelper

    def index
      @index = index_decorator(content_type)
      @content_items = content_type.content_items.find_by_tenant(current_user.active_tenant)
      add_breadcrumb content_type.name.pluralize
    end

    def new
      @content_item = content_type.content_items.new
      content_type.fields.each do |field|
        # TODO: Should this hit the Plugin Transaction Layer?
        @content_item.field_items << FieldItem.new(field: field)
      end
      @wizard = wizard_decorator(@content_item.content_type)

      add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
      add_breadcrumb 'New'
    end

    def edit
      @content_item = content_type.content_items.find_by_tenant(current_user.active_tenant).find_by_id(params[:id])
      @wizard = wizard_decorator(@content_item.content_type)

      title = @content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text'] # TODO: refactor this hardcoded Field reference
      add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
      add_breadcrumb title
      add_breadcrumb 'Edit'
    end

    def update
      begin
        update_content_item
      rescue ActiveRecord::RecordInvalid => e
        flash[:warning] = validation_message(e.message)
        @content_item = content_item_reload(content_type.content_items.find_by_id(params[:id]))
        @wizard = wizard_decorator(@content_item.content_type)

        title = @content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text'] # TODO: refactor this hardcoded Field reference
        add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
        add_breadcrumb title
        add_breadcrumb 'Edit'

        render :edit
      else
        flash[:success] = "Hooray! #{content_type.name} Updated!"
        redirect_to content_type_content_items_path
      end
    end

    def create
      begin
        create_content_item
      rescue ActiveRecord::RecordInvalid => e
        flash[:warning] = validation_message(e.message)
        @content_item = content_item_reload(content_type.content_items.new)
        @wizard = wizard_decorator(@content_item.content_type)

        add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
        add_breadcrumb 'New'

        render :new
      else
        flash[:success] = "Hooray! #{content_type.name} Created!"
        redirect_to content_type_content_items_path
      end
    end
  end
end
