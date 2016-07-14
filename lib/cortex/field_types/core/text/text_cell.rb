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
            raise 'not implemented'
          end
        end
      end
    end
  end
end
