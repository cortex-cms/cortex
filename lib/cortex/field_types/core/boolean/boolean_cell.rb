module Cortex
  module FieldTypes
    module Core
      module Boolean
        class BooleanCell < Cell::ViewModel
          property :form
          property :field
          property :value

          def checkbox
            render
          end

          def switch
            render
          end

          private

          def render_label
            form.label :data, field.name
          end

          def render_checkbox
            form.check_box 'data[value]', value
          end

          def render_switch
            raise 'not implemented'
          end
        end
      end
    end
  end
end
