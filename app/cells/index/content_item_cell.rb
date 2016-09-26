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
        @options[:content_item].field_items.find { |fi| fi.field_id == field[:id].to_i }.data.values[0]
      elsif field.has_key?(:method)
        @options[:content_item].send(field[:method])
      else
        ""
      end
    end

    def display_classes(display)
      display[:classes].join(" ") unless display.nil?
    end
  end
end
