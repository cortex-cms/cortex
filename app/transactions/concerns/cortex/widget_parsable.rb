module Cortex
  module WidgetParsable
    extend ActiveSupport::Concern

    included do
      def parse_widgets!(field_item)
        Cortex.tag_parsers.each do |tag_parser|
          parser_module = tag_parser.constantize
          field_item.data['text'] = parser_module.parse(field_item.data['text'])
        end
      end

      def widget_parsers_as_json
        # TODO: iterate through, provide JSON of Widget parser for frontend
        {}.to_json
      end
    end
  end
end
