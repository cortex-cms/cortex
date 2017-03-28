module DashboardHelper
  def news_feed
    news_feed = []

    if news_feed_tenant
      params = Hashr.new(page: 1, per_page: 10)
      posts_last_updated_at = Post.last_updated_at
      cache_key = "news-feed-#{posts_last_updated_at}"

      news_feed = Rails.cache.fetch(cache_key, expires_in: 30.minutes, race_condition_ttl: 10) do
        GetPosts.call(params: params, tenant: news_feed_tenant, published: true).posts.to_a.reverse
      end
    end

    news_feed
  end

  def news_feed_tenant
    @news_feed_tenant ||= Tenant.find_by_id(Cortex.config.cortex.news_feed.tenant)
  end

  def media_content_type
    @media_content_type = ContentType.find_by_name('Media')
  end

  def employer_blog_content_type
    @employer_blog_content_type = ContentType.find_by_name('Employer Blog')
  end
end
