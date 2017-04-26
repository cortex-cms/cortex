module WidgetParsers
  module MediaHelper
    # This needs to be abstracted to a plugin

    def self.parse(body)
      body_document = document_for body

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
        element.merge!({width: widget['width'], height: widget['height'], alt: widget['alt'], style: widget['style'], class: widget['class']})

        doc.send(tag_type, element)
      end.doc.root
    end

    def self.content_item_element(id)
      asset_field_item = ContentItem.find(id).field_items.find { |field_item| field_item.field.field_type_instance.is_a?(AssetFieldType) }
      url = asset_field_item.data['asset']['versions']['original']['url']

      if image? asset_field_item.data['asset']['versions']['original']['mime_type']
        element = { src: url }
        tag_type = 'img'
      else
        element = { href: url }
        tag_type = 'a'
      end

      [element, tag_type]
    end

    def self.image?(mime_type)
      MimeMagic.new(mime_type).mediatype == 'image'
    end
  end
end
