module Cortex
  module FieldTypes
    module Core
      module Text
        class TextCell < FieldCell
          def input
            render
          end

          def multiline_input
            render
          end

          private

          def value
            data&.[]('text') || @options[:default_value]
          end

          def render_label_and_input
            render_label(:text) do
              render_input
            end
          end

          def render_label
            @options[:form].label 'data[text]', field.name, class: 'mdl-textfield__label'
          end

          def render_input
            @options[:form].text_field 'data[text]', value: value, placeholder: @options[:placeholder], class: 'mdl-textfield__input'
          end

          def render_multiline_input
            @options[:form].text_area_tag 'data[text]', value: value # , cols: @options[:cols], rows: @options[:rows]
          end
        end
      end
    end
  end
end
