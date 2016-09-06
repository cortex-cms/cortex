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
        element = {src: Media.find_by_id(widget['id']).url}
        if widget['scale']
          element.merge!({scale: widget['scale']})
        else
          element.merge!({width: widget['width'], height: widget['height']})
        end

        doc.img(element)
      end.doc.root
    end
  end
end
