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

        end
      end
    end
  end
end
