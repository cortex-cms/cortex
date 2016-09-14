module Cortex
  module FieldTypes
    module Core
      module Tree
        class TreeCell < FieldCell
          def checkboxes
            render
          end

          def dropdown
            render
          end

          private

          def value
            data&.[]('values') || @options[:default_value]
          end

          def render_select
            @options[:form].select 'data[values]', metadata_values, {selected: value}
          end

          def metadata_values
            @options[:metadata]["data"]["tree_array"].map do |value|
              [value["node"]["name"], value["id"]]
            end
          end
        end
      end
    end
  end
end
