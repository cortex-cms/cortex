module WidgetParsers
  module MediaHelper
    def self.parse(body)
      @body = body

      widgets.each do |widget|
        widget.content = render_widget_content widget
      end

      widgets.to_html
    end

    def self.body_html
      Nokogiri::HTML::DocumentFragment.parse @body
    end

    def self.widgets
      body_html.css 'media'
    end

    def self.render_widget_content(widget)
      id = widget['id']
      scale = widget['scale']
      width = widget['width']
      height = widget['height']

      Nokogiri::HTML::Builder.new do |doc|
        if scale
          doc.img(
            src: Media.find_by_id(id).url,
            scale: scale
          )
        else
          doc.img(
            src: Media.find_by_id(id).url,
            width: width,
            height: height
          )
        end
      end.doc.root
    end
  end
end
