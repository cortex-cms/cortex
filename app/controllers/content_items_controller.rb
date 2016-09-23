class ContentItemsController < AdminController
  include ContentItemHelper

  def index
    @index = IndexDecoratorService.new(content_type: content_type)

    add_breadcrumb content_type.name.pluralize
  end

  def new
    @content_item = content_type.content_items.new
    content_type.fields.each do |field|
      @content_item.field_items << FieldItem.new(field: field)
    end
    @wizard = WizardDecoratorService.new(content_item: @content_item)

    add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
    add_breadcrumb 'New'
  end

  def edit
    @content_item = content_type.content_items.find_by_id(params[:id])
    @wizard = WizardDecoratorService.new(content_item: @content_item)

    add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
    add_breadcrumb "Edit #{@content_item.id}"
  end

  def update
    @content_item = ContentItemService.new(id: params[:id], content_item_params: content_item_params, current_user: current_user)

    if @content_item.update
      flash[:success] = "ContentItem updated"
    else
      flash[:warning] = "ContentItem failed to update! Reason: #{@content_item.errors.full_messages}"
    end

    redirect_to content_type_content_items_path
  end

  def create
    @content_item = ContentItemService.new(id: params[:id], content_item_params: content_item_params, current_user: current_user)

    if @content_item.create
      flash[:success] = "ContentItem created"
      redirect_to content_type_content_items_path
    else
      flash[:warning] = "ContentItem failed to create! Reason: #{@content_item.errors.full_messages}"
      render :new
    end
  end
end
