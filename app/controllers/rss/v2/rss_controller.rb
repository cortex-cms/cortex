module Rss
  module V2
    class RssController < ApplicationController
      include RssHelper

      def index
        @content_items = rss_content_type.content_items
      end
    end
  end
end
