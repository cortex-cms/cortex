module Cortex
  module FieldTypes
    module Core
      module Text
        class TextCell < FieldCell
          property :cols
          property :rows

          def input
            render
          end

          def multiline_input
            render
          end

          private

          def value
            if data
              data['text'] || @options[:default_value]
            else
              @options[:default_value]
            end
          end

          def render_input
            @options[:form].text_field 'data[text]', value: value, placeholder: @options[:placeholder]
          end

          def render_multiline_input
            @options[:form].text_area_tag 'data[text]', value: @options[:default_value], cols: @options[:cols], rows: @options[:rows]
          end
        end
      end
    end
  end
end
