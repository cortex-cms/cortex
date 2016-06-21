class ContentItemsController < ApplicationController

  def new
    @content_type = ContentType.find(params[:content_type_id])
    @content_item = @content_type.content_items.new
  end

  def create
    binding.pry
    @content_item = ContentItem.new(content_item_params)
    if @content_item.save
      redirect_to content_types_path(content_type_id: params[:content_type_id])
    else
      @content_type = ContentType.find(params[:content_type_id])
      render :new
    end
  end

  private

  def content_item_params
    params.require(:content_item).permit(
      :author_id,
      :creator_id,
      :content_type_id,
      field_items_attributes: field_items_attributes_params
    )
  end

  def field_items_attributes_params
    [
      :field_id,
      :data
    ]
  end
end
