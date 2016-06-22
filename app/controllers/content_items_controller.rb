class ContentItemsController < ApplicationController
  def new
    @content_type = ContentType.find(params[:content_type_id])
    @content_item = @content_type.content_items.new
  end

  def create
    binding.pry
    @content_type = ContentType.find(params[:content_type_id])
    @content_item = ContentItem.new(content_item_params)
    if @content_item.save
      redirect_to content_types_path(content_type_id: params[:content_type_id])
    else
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
    field_items_attributes_as_array = params["content_item"]["field_items_attributes"].map do |key, value|
      value
    end

    field_items_attributes_as_array.map do |field_items_attribute|
      permit_recursive_params(field_items_attribute)
    end
  end

  def permit_recursive_params(params)
    params.map do |key, value|
      next if key == 'id' # TODO: This must go away.

      if value.is_a?(Array)
        {key => [permit_recursive_params(value.first)]}
      elsif value.is_a?(Hash) || value.is_a?(ActionController::Parameters)
        {key => permit_recursive_params(value)}
      else
        key
      end
    end
  end
end
