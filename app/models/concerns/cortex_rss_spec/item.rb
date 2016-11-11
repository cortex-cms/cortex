module CortexRssSpec
  module Item
    def self.feed
      %w(
        title link description author category comments enclosure guid pubDate source
      )
    end
  end
end
