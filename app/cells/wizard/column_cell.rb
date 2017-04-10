module Wizard
  class ColumnCell < Cell::ViewModel
    property :heading
    property :grid_width
    property :display
    property :elements
    property :description

    def show
      render
    end

    private

    def grid_class
      "mdl-cell--#{grid_width}-col"
    end
  end
end
