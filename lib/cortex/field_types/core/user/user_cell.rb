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
            @options[:form].select 'data[user_id]', options_for_select: user_data_for_select, selected: {}
          end

          def user_data_for_select
            @options[:user_data].map{ |user| [user.fullname, user.id] }
          end
        end
      end
    end
  end
end
