xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    @rss_decorator.each_pair do |key, value|
      unless key == "items"
        xml.tag! key, value
      end
    end

    @content_items.each_with_index do |content_item|
      xml.item do
        @rss_decorator['items'].each_pair do |key, value|
          xml.tag! key, content_item_value(content_item, value)
        end
      end
    end

    # for article in @posts
    #   xml.item do
    #     xml.title article.title
    #     xml.author article.custom_author
    #     xml.pubDate DateTime.parse(article.published_at).rfc822
    #     xml.link ENV['LINK_ROOT'] + article.slug
    #     xml.guid article.id
    #     xml.description "#{image_tag article.featured_media.url}<br><br>#{article.body}" unless article.featured_media.nil?
    #   end
    # end
  end
end
