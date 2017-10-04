module DashboardHelper
  def news_feed
    [] # need to re-implement this feature using Beta Cortex blogposts
  end

  def news_feed_tenant
    @news_feed_tenant ||= Tenant.find_by_id(Cortex.config.cortex.news_feed.tenant)
  end

  def media_content_type
    @media_content_type ||= current_user.active_tenant.search_up_organization_for(ContentType, :name, 'Media').first
  end

  def employer_blog_content_type
    @employer_blog_content_type ||= current_user.active_tenant.search_up_organization_for(ContentType, :name, 'Employer Blog').first
  end
end
