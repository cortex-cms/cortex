module Wizard
  class FieldCell < Cell::ViewModel
    property :id
    property :label
    property :input

    def show
      render
    end
  end
end
