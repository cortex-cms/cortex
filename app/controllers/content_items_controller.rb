class ContentItemsController < AdminController
  include ContentItemHelper

  def index
    @content_items_grid = initialize_grid(content_type.content_items)

    add_breadcrumb content_type.name.pluralize
  end

  def new
    @content_item = content_type.content_items.new

    add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
    add_breadcrumb 'New'
  end

  def edit
    @content_item = content_type.content_items.find_by_id(params[:id])

    add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
    add_breadcrumb "Edit #{@content_item.id}"
  end

  def update
    @content_item = content_type.content_items.find_by_id(params[:id])

    if @content_item.update(content_item_params)
      flash[:success] = "ContentItem updated"
    else
      flash[:warning] = "ContentItem failed to update!"
    end

    render :index
  end

  def create
    @content_item = ContentItem.new(content_item_params)

    if @content_item.save
      flash[:success] = "ContentItem updated"
    else
      flash[:warning] = "ContentItem failed to update!"
    end

    render :index
  end
end
