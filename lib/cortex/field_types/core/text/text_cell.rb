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

          def render_input
            @options[:form].text_field 'data[text]', value: @options[:default_value]
          end

          def render_multiline_input
            raise 'not implemented'
          end
        end
      end
    end
  end
end
