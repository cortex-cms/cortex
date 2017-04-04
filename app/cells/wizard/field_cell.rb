module Wizard
  class FieldCell < Cell::ViewModel
    property :id
    property :label
    property :input
    property :render_method
    property :tooltip

    def show
      render
    end

    private

    def field_item
      context[:content_item].field_items.select { |field_item| field_item.field_id == id }[0]
    end

    def field
      ::Field.find_by_id(id)
    end

    def field_type
      field.field_type_instance
    end
  end
end
