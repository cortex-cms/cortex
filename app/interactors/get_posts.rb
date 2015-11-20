class GetPosts
  include Interactor

  SEARCH_PARAMS = %w{q categories industries type job_phase post_type author}

  def call
    binding.pry
    posts = ::Post
    posts = posts.search_with_params(context.params).records if has_search_params?
    posts = posts.find_by_tenant_id(context.tenant) if context.tenant
    posts = posts.published if context.published
    context.posts = posts.page(context.parmas.page).per(context.params.per_page).order(published_at: :desc)
  end

  private

  def has_search_params?
    Array(context.params.keys & SEARCH_PARAMS).length > 0
  end
end
