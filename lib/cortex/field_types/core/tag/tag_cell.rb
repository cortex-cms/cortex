module Cortex
  module FieldTypes
    module Core
      module Tag
        class TagCell < FieldCell

          def tag_picker
            render
          end

          private

          def value
            if data
              data['tag_list'] || @options[:default_value]
            else
              @options[:default_value]
            end
          end

          def render_tag_field
            @options[:form].text_field 'data[tag_list]', value: value, placeholder: @options[:placeholder],  'data-role'=>'tagsinput'
          end

        end
      end
    end
  end
end
