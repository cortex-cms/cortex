class ContentItemsController < ApplicationController

  def new
    @content_type = ContentType.find(params[:content_type_id])
    @content_item = ContentItem.new
  end

  def create
    binding.pry
    content_item = ContentItem.new(content_item_params)
    if content_item.save
      params[:field_item][:data].each do |field_items|
      end
      redirect_to content_type_content_items_path(content_type_id: params[:content_type_id])
    else
    end
  end

  private

  def content_item_params
    params.require(:content_item).permit(
    :author,
    :creator,
    :content_type_id,
    field_items_attributes: field_item_params
    )
  end

  def field_item_params
    [
      :field_id,
      :content_item_id,
      :data
    ]
  end
end
