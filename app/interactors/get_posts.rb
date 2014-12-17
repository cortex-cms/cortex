class GetPosts
  include Interactor

  SEARCH_PARAMS = %i{q categories industries type job_phase post_type author}

  def call
    posts = ::Post
    posts = posts.find_by_tenant_id(context.tenant) if context.tenant
    posts = posts.published if context.published
    posts = posts.search_with_params(context.params).records if has_search_params?
    context.posts = posts.page(context.page).per(context.per_page).order(published_at: :desc)
  end

  private

  def has_search_params?
    Array(context.params.keys & SEARCH_PARAMS).length > 0
  end
end
