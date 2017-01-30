class ContentItemsController < AdminController
  include ContentItemHelper
  include PopupHelper

  def index
    @index = IndexDecoratorService.new(content_type: content_type)
    @content_items = content_type.content_items
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

    title = @content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text']
    add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
    add_breadcrumb title
    add_breadcrumb 'Edit'
  end

  def update
    if content_item.update
      flash[:success] = "ContentItem updated"
    else
      flash[:warning] = "ContentItem failed to update! Reason: #{@content_item.errors.full_messages}"
    end

    redirect_to content_type_content_items_path
  end

  def create
    begin
      content_item.create
    rescue Exception => e
      @paramTrack = {}
      params['content_item']['field_items_attributes'].each do |param|
        @paramTrack[params['content_item']['field_items_attributes'][param]['field_id']] = params['content_item']['field_items_attributes'][param]
      end
      flash[:warning] = "ContentItem failed to create! Reason: #{e.message}"
      @content_item = content_type.content_items.new
      content_type.fields.each do |field|
        d = {}
        if @paramTrack[field.id]
          d = Hash(@paramTrack[field.id])
        end
        @content_item.field_items << FieldItem.new(field: field, data: d["data"] || d )
      end

      @wizard = WizardDecoratorService.new(content_item: @content_item)

      render :new
    else
     flash[:success] = "ContentItem created"
     redirect_to content_type_content_items_path
   end
  end
end
