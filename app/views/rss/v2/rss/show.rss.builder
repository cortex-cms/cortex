if Rails.cache.fetch("rss/v2/#{content_type.name}/show_feed")
  xml << Rails.cache.fetch("rss/v2/#{content_type.name}/show_feed")
end

Rails.cache.fetch("rss/v2/#{content_type.name}/show_feed", expires_in: 1.hours, race_condition_ttl: 10) do
  xml.instruct! :xml, :version => "1.0"
  xml.rss :version => "2.0" do
    xml.channel do
      @rss_decorator.each_pair do |key, value|
        unless key.include?("items")
          xml.tag! key, value
        end
      end

      xml.item do
        @rss_decorator['show_items'].each_pair do |key, value|
          xml.tag! key, parse_data(key, value, content_item)
        end
      end
    end
  end
end
