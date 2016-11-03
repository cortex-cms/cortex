module CortexRssSpec
  module Channel
    def self.feed
      %w(
        title link description language copyright managingEditor webMaster pubDate
        lastBuildDate category docs cloud ttl rating textInput
      )
    end
  end
end
