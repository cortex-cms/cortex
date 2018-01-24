module Cortex
  module Wizard
    class StepCell < Cortex::ApplicationCell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormHelper

      property :name
      property :heading
      property :description
      property :columns

      def show
        render
      end
    end
  end
end
