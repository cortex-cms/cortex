module Index
  class ContentItemCell < Cell::ViewModel
    def column
      render
    end

    def edit
      render
    end

    private

    def render_edit
      content_type = @options[:content_item].content_type
      content_item = @options[:content_item]

      link_to "Edit #{content_item.id}", edit_content_type_content_item_path(content_type.id, content_item.id)
    end

    def render_column(field, display)
      if field.has_key?(:id)
        @options[:content_item].field_items.find { |fi| fi.field_id == field[:id].to_i }.data.values[0]
      elsif field.has_key?(:method)
        @options[:content_item].send(field[:method])
      else
        ""
      end
    end
  end
end
