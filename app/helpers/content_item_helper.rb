module ContentItemHelper
  def content_type
    @content_type ||= ContentType.find_by_id(params[:content_type_id])
  end

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

    permitted_keys = {}
    field_items_attributes_as_array.each {|hash| hash.each_key {|key| permitted_keys [key.to_s] = [] } }

    permit_attribute_params(field_items_attributes_as_array, permitted_keys)
  end

  def permit_attribute_params(param_array, permitted_keys)
    param_array.each do |param_hash|
      permitted_keys.keys.each do |key|
        if param_hash[key].is_a?(Hash)
          permitted_keys[key] << param_hash[key].keys
        end
        permitted_keys[key].flatten!
      end
    end

    sanitize_parameters(permitted_keys)
  end

  def sanitize_parameters(permitted_keys)
    strong_params_array = []

    permitted_keys.each_pair do |key, value|
      if value.empty?
        strong_params_array << key
      else
        strong_params_array << {key => value}
      end
    end

    strong_params_array
  end

end
