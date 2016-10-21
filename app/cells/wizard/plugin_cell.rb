module Wizard
  class PluginCell < Cell::ViewModel
    def show
      render
    end

    private

    def plugin_field_item
      field_id = plugin_info[:data][:field_id]
      context[:content_item].field_items.find { |field_item| field_item.field_id == field_id } || {}
    end

    def display
      {}
    end

    def plugin_info
      @options[:plugin_info]
    end

    def plugin_cell_information
      cell(plugin_info[:class_name], plugin_field_item, display: display).(plugin_info[:render_method])
    end
  end
end
