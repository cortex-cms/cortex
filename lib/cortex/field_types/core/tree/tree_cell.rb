module Cortex
  module FieldTypes
    module Core
      module Tree
        class TreeCell < FieldCell
          def tree
            render
          end

          def checked
            true
          end

          private

          def form
            @options[:form]
          end

          def nodes
            model.data.values_at([:category])
          end

          def categories
            CategoryTree.build.values_at([:category, :category_id])
          end

          def index
            options[:index]
          end

        end
      end
    end
  end
end
