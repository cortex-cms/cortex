xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Cortex Posts"
    xml.author "CareerBuilder"
    xml.description "All Cortex Posts"
    xml.link "http://admin.cbcortex.com/"
    xml.language "en"

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
