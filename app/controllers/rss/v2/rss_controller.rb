class Rss::V2::RssController < ApplicationController
  include RssHelper
  before_action :perform_common_tasks

  def index
    @content_items = rss_content_type.content_items
  end

  def show
    @content_item = ContentItem.find(params[:id])
  end

  private

  def perform_common_tasks
    @rss_decorator = Hashie::Mash.new(rss_content_type.rss_decorator.data)
  end
end
