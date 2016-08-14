module Wizard
  class ColumnCell < Cell::ViewModel
    property :heading
    property :grid_width
    property :display
    property :fields

    def show
      render
    end

    private

    def render_heading
      heading
    end

    def render_container
      grid_width
    end
  end
end
