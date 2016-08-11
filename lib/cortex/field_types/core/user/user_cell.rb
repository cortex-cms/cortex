module Cortex
  module FieldTypes
    module Core
      module User
        class UserCell < FieldCell

          def dropdown
            render
          end

          private

          def value
            if data
              data['user_id'] || @options[:default_value]
            else
              @options[:default_value]
            end
          end

          def render_select_options
            options = ""
            @options[:user_data].each do |user_info|
              options += "<option value='#{user_info[1]}'>#{user_info[0]}</option>"
            end
            options.html_safe
          end

        end
      end
    end
  end
end
