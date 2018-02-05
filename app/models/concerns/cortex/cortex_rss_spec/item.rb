module Cortex
  module CortexRssSpec
    module Item
      def self.feed
        %w(
        title link description author category comments enclosure guid pubDate source media:content
      )
      end
    end
  end
end
