# TODO: The entire Publish system needs to be reworked to avoid hardcoded references and data integrity issues

module Cortex
  class GetPublishStateTransaction < Cortex::ApplicationTransaction
    step :sort_field_items
    step :process

    def sort_field_items(content_item)
      sorted_field_items = content_item.field_items.select do |field_item|
        field_item.field.field_type_instance.is_a?(DateTimeFieldType) && !field_item.field.metadata["state"].nil?
      end.sort_by {|field_item| field_item.data["timestamp"]}.reverse

      Success({
                sorted_field_items: sorted_field_items,
                content_item: content_item
              })
    end

    def process(input)
      timestamp_field_item = input[:sorted_field_items].find do |field_item|
        field_item.data['timestamp'].present? && DateTime.now > DateTime.parse(field_item.data["timestamp"])
      end

      active_state = timestamp_field_item ? timestamp_field_item.field.metadata["state"] : input[:content_item].state.titleize
      Success(active_state)
    end
  end
end
