module Cortex
  module ContentItemable
    extend ActiveSupport::Concern

    included do
      def field_items_attributes(content_item_params)
        content_item_params['field_items_attributes']
      end

      def last_updated_by(current_user)
        { updated_by: current_user }
      end
    end
  end
end
