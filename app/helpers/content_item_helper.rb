module ContentItemHelper
  def content_type
    @content_type ||= ContentType.find_by_id(params[:content_type_id])
  end

  def content_item
    @content_item ||= ContentItemService.new(id: params[:id], content_item_params: content_item_params, current_user: current_user, state: params[:content_item][:state])
  end

  def content_item_reload(content_item)
    @content_item = content_item
    content_type.fields.each do |field|
      @content_item.field_items << FieldItem.new(field: field, data: field_item_param_data(params_lookup[field.id]))
    end
    @content_item
  end

  def content_item_params
    params.require(:content_item).permit(
      :creator_id,
      :content_type_id,
      field_items_attributes: field_items_attributes_params,
    )
  end

  def field_items_attributes_params
    field_items_attributes_as_array = params["content_item"]["field_items_attributes"].map do |key, value|
      value
    end

    permitted_keys = {}
    field_items_attributes_as_array.each { |hash| hash.each_key { |key| permitted_keys[key.to_s] = [] } }

    permit_attribute_params(field_items_attributes_as_array, permitted_keys)
  end

  def permit_attribute_params(param_array, permitted_keys)
    param_array.each do |param_hash|
      permitted_keys.keys.each do |key|
        if param_hash[key].is_a?(Hash)
          permitted_keys[key] << permit_param(param_hash[key])
        end
        permitted_keys[key].flatten!
      end
    end

    sanitize_parameters(permitted_keys)
  end

  def permit_param(param)
    if param.values[0].is_a?(Hash)
      { param.keys[0].to_sym => param.values[0].keys }
    else
      param.keys
    end
  end

  def sanitize_parameters(permitted_keys)
    permitted_keys.map do |key, value|
      if value.empty?
        key
      else
        { key => value.uniq }
      end
    end
  end

  def index_parameters
    @index_parameters = {}
    params['content_item']['field_items_attributes'].each do |param|
      @index_parameters[params['content_item']['field_items_attributes'][param]['field_id']] = params['content_item']['field_items_attributes'][param]
    end
    @index_parameters
  end

  def params_lookup
    @params_lookup ||= index_parameters
  end

  def field_item_param_data(field_item_params)
    return {} unless field_item_params
    params_hash = field_item_params.to_unsafe_h
    params_hash['data'] || {}
  end

  def validation_message(base_message)
    msg_array = base_message.gsub('Validation failed:', '').gsub('Field items', '').split(',')
    msg_array.map { |message| message.strip.titleize }
  end
end
