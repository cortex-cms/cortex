if Rails.cache.fetch("rss-v2-#{content_type.name}")
  xml << Rails.cache.fetch("rss-v2-#{content_type.name}")
end

Rails.cache.fetch("rss-v2-#{content_type.name}", expires_in: 1.hours, race_condition_ttl: 10) do
  xml.instruct! :xml, :version => "1.0"
  xml.rss :version => "2.0" do
    xml.channel do
      rss_decorator["channel"].each_pair do |key, value|
        xml.tag! key_name(key), tag_data(value, nil) if channel_spec.include?(key_name(key))
      end

      @content_items.each do |rss_content_item|
        xml.item do
          rss_decorator["item"].each_pair do |key, value|
            if value.has_key?('multiple')
              tag_data(value, rss_content_item).split(value["multiple"]).each do |multi_value|
                xml.tag! key_name(key), multi_value if item_spec.include?(key_name(key))
              end
            elsif value.has_key?('encode')
              xml.tag! "#{key_name(key)}:encoded" do
                xml.cdata! tag_data(value, rss_content_item)
              end
            else
              xml.tag! key_name(key), tag_data(value, rss_content_item) if item_spec.include?(key_name(key))
            end
          end
        end
      end
    end
  end
end
