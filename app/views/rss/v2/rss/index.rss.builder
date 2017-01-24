if Rails.cache.fetch("rss-v2-#{content_type.name}")
  xml << Rails.cache.fetch("rss-v2-#{content_type.name}")
end

Rails.cache.fetch("rss-v2-#{content_type.name}", expires_in: 30.minutes, race_condition_ttl: 10) do
  xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
  xml.rss version: '2.0',
          'xmlns:content': 'http://purl.org/rss/1.0/modules/content/',
          'xmlns:wfw': 'http://wellformedweb.org/CommentAPI/',
          'xmlns:dc': 'http://purl.org/dc/elements/1.1/',
          'xmlns:atom': 'http://www.w3.org/2005/Atom',
          'xmlns:sy': 'http://purl.org/rss/1.0/modules/syndication/',
          'xmlns:slash': 'http://purl.org/rss/1.0/modules/slash/',
          'xmlns:media': 'http://search.yahoo.com/mrss/' do
    xml.channel do
      rss_decorator["channel"].each_pair do |key, value|
        xml.tag! key_name(key), tag_data(value, nil) if channel_spec.include?(key_name(key))
      end

      @content_items.each do |rss_content_item|

        xml.item do
          rss_decorator["item"].each_pair do |key, value|
            tag_data = tag_data(value, rss_content_item)
            unless tag_data.blank?
              if value.has_key?('multiple')
                tag_data.split(value["multiple"]).each do |multi_value|
                  xml.tag! key_name(key), multi_value, value['attributes'] if item_spec.include?(key_name(key))
                end
              elsif value.has_key?('encode')
                xml.tag! "#{key_name(key)}:encoded", value['attributes'] do
                  xml.cdata! tag_data
                end
              elsif item_spec.include?(key)
                xml.tag! key, tag_data, value['attributes']
              end
            end
          end
        end
      end
    end
  end
end
