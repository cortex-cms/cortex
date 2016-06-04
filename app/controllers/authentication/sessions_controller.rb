class Authentication::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if params[:legacy] == '1'
      legacy_root_path
    else
      root_path
    end
  end

  def new
    super do |user|
      params = Hashr.new(page: 1, per_page: 10)
      tenant = Tenant.find_by_id(Cortex.config.cortex.news_feed.tenant)

      @news_feed_posts = ::GetPosts.call(params: params, tenant: tenant, published: true).posts
    end
  end
end
