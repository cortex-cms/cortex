module Index
  class ContentItemCell < Cell::ViewModel
    def column
      render
    end

    def edit
      render
    end

    private

    def render_table_data(field)
      if field.has_key?(:id)
        @options[:content_item].field_items.find { |fi| fi.field_id == field[:id] }.data.values[0]
      elsif field.has_key?(:method)
        @options[:content_item].send(field[:method])
      elsif field.has_key?(:plugin)
        cell(field[:plugin][:class_name], plugin_field_item(field), display: field[:plugin][:display], config: field[:plugin][:config]).(field[:plugin][:render_method])
      else
        ""
      end
    end

    def display_classes(display)
      display[:classes].join(" ") unless display.nil?
    end

    def plugin_field_item(field)
      field_id = field[:plugin][:data][:field_id]
      @options[:content_item].field_items.find { |field_item| field_item.field_id == field_id } || {}
    end
  end
end
