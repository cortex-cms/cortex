module Wizard
  class FieldCell < Cell::ViewModel
    property :id
    property :label
    property :input

    def show
      render
    end

    private

    def field
      ::Field.find_by_id(id)
    end

    def field_type
      field.field_type_instance
    end
  end
end
