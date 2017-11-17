class ContentItemsController < AdminController
  include ContentItemHelper
  include PopupHelper

  def index
    @index = IndexDecoratorService.new(content_type: content_type)
    @content_items = content_type.content_items.find_by_tenant(current_user.active_tenant)
    add_breadcrumb content_type.name.pluralize
  end

  def new
    @content_item = content_type.content_items.new
    content_type.fields.each do |field|
      # TODO: Should this hit the Plugin Transaction Layer?
      @content_item.field_items << FieldItem.new(field: field)
    end
    @wizard = WizardDecoratorService.new(content_item: @content_item)

    add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
    add_breadcrumb 'New'
  end

  def edit
    @content_item = content_type.content_items.find_by_tenant(current_user.active_tenant).find_by_id(params[:id])
    @wizard = WizardDecoratorService.new(content_item: @content_item)

    title = @content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text'] # TODO: refactor this hardcoded Field reference
    add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
    add_breadcrumb title
    add_breadcrumb 'Edit'
  end

  def update
    begin
      content_item.update
    rescue ActiveRecord::RecordInvalid => e
      flash[:warning] = validation_message(e.message)
      @content_item = content_item_reload(content_type.content_items.find_by_id(params[:id]))
      @wizard = WizardDecoratorService.new(content_item: @content_item)

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
      content_item.create
    rescue ActiveRecord::RecordInvalid => e
      flash[:warning] = validation_message(e.message)
      @content_item = content_item_reload(content_type.content_items.new)
      @wizard = WizardDecoratorService.new(content_item: @content_item)

      add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
      add_breadcrumb 'New'

      render :new
    else
      flash[:success] = "Hooray! #{content_type.name} Created!"
      redirect_to content_type_content_items_path
    end
  end
end
