class Rss::V2::RssController < ApplicationController
  include RssHelper

  before_action :perform_common_tasks

  def index
  end

  def show
  end

  private

  def perform_common_tasks
    @content_items = content_type.content_items
    @rss_decorator = Hashie::Mash.new(content_type.rss_decorator.data)
    @config = @rss_decorator.extract!("config")
  end
end
