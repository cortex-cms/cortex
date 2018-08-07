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

      title = @content_item.field_items.find {|field_item| field_item.field.name == 'Title'}.data['text'] # TODO: refactor this hardcoded Field reference
      add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
      add_breadcrumb title
      add_breadcrumb 'Edit'
    end

    def update
      update_content_item
        .with_step_args(
          execute_content_item_state_change: [state: params[:content_item][:state]]
        )
        .call(id: params[:id], content_type: content_type,
              content_item_params: content_item_params, current_user: current_user) do |m|
        m.success do |content_item|
          flash[:success] = "#{content_type.name} successfully updated"
          redirect_to content_type_content_items_path
        end

        m.failure :persist_content_item do |errors|
          flash[:warning] = clean_error_messages(errors.full_messages)
          render_update_content_item_error
        end

        m.failure do |error|
          flash[:warning] = ['Unknown System Error']
          render_update_content_item_error
        end
      end
    end

    def create
      create_content_item
        .with_step_args(
          execute_content_item_state_change: [state: params[:content_item][:state]]
        )
        .call(id: params[:id], content_type: content_type,
              content_item_params: content_item_params, current_user: current_user) do |m|
        m.success do |content_item|
          flash[:success] = "#{content_type.name} successfully created"
          redirect_to content_type_content_items_path
        end

        m.failure :persist_content_item do |errors|
          flash[:warning] = clean_error_messages(errors.full_messages)
          render_create_content_item_error
        end

        m.failure do |error|
          flash[:warning] = ['Unknown System Error']
          render_update_content_item_error
        end
      end
    end
  end
end
