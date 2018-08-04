module Cortex
  module ContentItemable
    extend ActiveSupport::Concern

    included do
      include Cortex::WidgetParsable

      def parse_field_items!(content_item)
        content_item.field_items.each do |field_item|
          if field_item.field.metadata && field_item.field.metadata['parse_widgets']
            parse_widgets!(field_item)
          end
        end
        content_item
      end

      def field_items_attributes(content_item_params)
        content_item_params['field_items_attributes']
      end

      def content_item_attributes(content_item_params, creator, content_type, field_items, current_user)
        attributes = content_item_params || { creator: creator, content_type: content_type, field_items: field_items }
        attributes.merge! latest_history_patch(current_user)
      end

      def latest_history_patch(current_user)
        history_patch = {}
        history_patch.merge! last_updated_by(current_user)
      end

      def last_updated_by(current_user)
        { updated_by: current_user }
      end

      def execute_state_change(content_item, state)
        if state && content_item.can_transition?(state)
          state_method = "#{state}!"
          content_item.send(state_method)
        end
      end
    end
  end
end
