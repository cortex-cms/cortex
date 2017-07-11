module DashboardHelper
  def news_feed
    [] # need to re-implement this feature using Beta Cortex blogposts
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
