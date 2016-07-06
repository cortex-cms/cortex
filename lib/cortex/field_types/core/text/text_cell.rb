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

          def render_input
            @options[:form].text_field 'data[text]', value: @options[:default_value]
          end

          def render_multiline_input
            @options[:form].text_area_tag 'data[text]', value: @options[:default_value], cols: @options[:cols], rows: @options[:rows]
          end
        end
      end
    end
  end
end
