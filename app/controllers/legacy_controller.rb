class LegacyController < ApplicationController
  before_action :authenticate_user!, :add_gon

  def index
    render layout: 'legacy_application'
  end

  def published_and_scheduled_posts_as_csv
    last_updated_at = Post.last_updated_at
    cache_key = "published-and-scheduled-posts-csv-feed-#{last_updated_at}-#{current_user.tenant.id}"

    csv = ::Rails.cache.fetch(cache_key, expires_in: 30.minutes, race_condition_ttl: 10) do
      posts = ::GetPosts.call(tenant: current_user.tenant, published: true, scheduled: true).posts
      posts.records.to_published_and_scheduled_posts_csv
    end

    send_data csv, filename: "published-and-scheduled-posts-#{Date.today}.csv"
  end

  private

  def add_gon
    gon.push({
               current_user: current_user.as_json,
               settings: {
                 cortex_base_url: "#{root_url}api/v1",
                 paging: {
                   defaultPerPage: 10
                 }
               }
             })
  end
end
