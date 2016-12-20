module WidgetParsers
  module MediaHelper
    def self.parse(body)
      body_document = document_for(body)

      widget_nodes_for(body_document).each do |widget_node|
        widget_node.inner_html = render_widget_inner widget_node
      end

      body_document.to_html
    end

    def self.document_for(html)
      Nokogiri::HTML::DocumentFragment.parse html
    end

    def self.widget_nodes_for(document)
      document.css 'media'
    end

    def self.render_widget_inner(widget)
      Nokogiri::HTML::Builder.new do |doc|
        element, tag_type = content_item_element(widget['id'])
        if widget['scale']
          element.merge!({scale: widget['scale']})
        else
          element.merge!({width: widget['width'], height: widget['height']})
        end

        doc.send(tag_type, element)
      end.doc.root
    end

    def self.content_item_element(id)
      asset_field_item = ContentItem.find(id).field_items.find { |field_item| field_item.field.field_type == "asset_field_type" }
      url = asset_field_item.data["asset"]["url"]

      if asset_field_item.data["asset"]["content_type"].include?("image")
        element = { src: url }
        tag_type = "img"
      else
        element = { href: url }
        tag_type = "a"
      end

      [element, tag_type]
    end
  end
end
