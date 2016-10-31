module Rss
  module V2
    class RssController < ApplicationController
      include RssHelper

      def index
        @content_items = content_type.content_items
      end
    end
  end
end
