module WidgetParsersHelper
  def parse_widgets!(field_item)
    Cortex.available_tag_parsers.each do |tag_parser|
      # TODO: Alternatively, we could decide to dynamically iterate through all
      # modules inside the WidgetParsers namespace. This way feels brittle.
      parser_module = "WidgetParsers::#{tag_parser.capitalize}Helper".constantize
      field_item.data['text'] = parser_module.parse(field_item.data['text'])
    end
  end

  def widget_parsers_as_json
    # TODO: iterate through, provide JSON of Widget parser for frontend
    {}.to_json
  end
end
