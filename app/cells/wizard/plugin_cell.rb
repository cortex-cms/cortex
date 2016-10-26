module Wizard
  class PluginCell < Cell::ViewModel
    def show
      render
    end

    private

    def field_item
      field_id = plugin_info[:data][:field_id]
      context[:content_item].field_items.find { |field_item| field_item.field_id == field_id } || {}
    end

    def display
      {}
    end

    def plugin_info
      @options[:plugin_info]
    end

    def cell_information
      cell(plugin_info[:class_name], field_item, display: display, config: plugin_info[:config]).(plugin_info[:render_method].to_sym)
    end
  end
end
