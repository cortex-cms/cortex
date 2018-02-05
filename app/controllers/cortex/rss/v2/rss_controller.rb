require_dependency 'cortex/application_controller'

module Cortex
  module Rss
    module V2
      class RssController < ApplicationController
        include RssHelper

        def index
          @content_items = rss_content_type.content_items.select { |content_item| content_item.published? }
        end
      end
    end
  end
end
