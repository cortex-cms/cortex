class GetPosts
  include Interactor

  SEARCH_PARAMS = %w(q categories industries type job_phase post_type author).freeze

  def call
    posts = ::Post

    if has_search_params?
      posts = posts.search_with_params(context.params, context.tenant, context.published)
    else
      posts = posts.show_all(context.tenant, context.published)
    end

    posts = posts.page(context.params.page).per(context.params.per_page)
    context.posts = posts.records
  end

  private

  def has_search_params?
    param_keys = context.params.keys || []
    (param_keys & SEARCH_PARAMS).any?
  end
end
