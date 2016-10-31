xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    @rss_decorator.each_pair do |key, value|
      binding.pry
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
