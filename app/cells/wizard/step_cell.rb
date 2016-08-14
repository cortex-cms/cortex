module Wizard
  class StepCell < Cell::ViewModel
    property :name
    property :heading
    property :columns

    def show
      render
    end

    private

    def render_columns
    end

    def render_heading
      heading
    end
  end
end
