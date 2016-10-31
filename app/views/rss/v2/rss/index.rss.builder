xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    @rss_decorator.each_pair do |key, value|
      unless key.include?("items")
        xml.tag! key, value
      end
    end

    @content_items.each_with_index do |content_item|
      xml.item do
        @rss_decorator['index_items'].each_pair do |key, value|

        end
      end
    end
  end
end
