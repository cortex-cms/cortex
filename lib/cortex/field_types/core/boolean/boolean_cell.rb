module Cortex
  module FieldTypes
    module Core
      module Boolean
        class BooleanCell < FieldCell
          def checkbox
            render
          end

          def switch
            render
          end

          private

          def value
            if data
              data['value'] == 'true' ? true : false
            else
              false
            end
          end

          def checkbox_id
            @options[:field_name]
          end

          def render_checkbox_label
            @options[:form].label :data, field.name, class: 'mdl-checkbox__label'
          end

          def render_checkbox
            @options[:form].check_box 'data[value]', { checked: value, class: 'mdl-checkbox__input', id: checkbox_id }, 'true', 'false'
          end

          def render_switch
            raise 'not implemented'
          end
        end
      end
    end
  end
end
