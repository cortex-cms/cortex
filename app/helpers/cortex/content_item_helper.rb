module Cortex
  module ContentItemHelper
    def content_type
      @content_type ||= Cortex::ContentType.find_by_id(params[:content_type_id])
    end

    def create_content_item
      CreateContentItemTransaction.new
    end

    def update_content_item
      UpdateContentItemTransaction.new
    end

    def render_create_content_item_error
      @content_item = content_item_reload(content_type.content_items.new)
      @wizard = wizard_decorator(@content_item.content_type)

      add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
      add_breadcrumb 'New'

      render :new
    end

    def render_update_content_item_error
      @content_item = content_item_reload(content_type.content_items.find_by_id(params[:id]))
      @wizard = wizard_decorator(@content_item.content_type)

      title = @content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text'] # TODO: refactor this hardcoded Field reference
      add_breadcrumb content_type.name.pluralize, :content_type_content_items_path
      add_breadcrumb title
      add_breadcrumb 'Edit'

      render :edit
    end

    def content_item_reload(content_item)
      @content_item = content_item
      content_type.fields.each do |field|
        @content_item.field_items << Cortex::FieldItem.new(field: field, data: field_item_param_data(params_lookup[field.id]))
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
      field_items_attributes_as_array = params['content_item']['field_items_attributes'].values

      permitted_keys = {}
      field_items_attributes_as_array.each {|hash| hash.each_key {|key| permitted_keys[key.to_s] = []}}

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
        {param.keys[0].to_sym => param.values[0].keys}
      else
        param.keys
      end
    end

    def sanitize_parameters(permitted_keys)
      permitted_keys.map do |key, value|
        if value.empty?
          key
        else
          {key => value.uniq}
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

    def clean_error_messages(messages)
      messages.map {|message| message.gsub('Field items', '').strip.titleize}
    end
  end
end
