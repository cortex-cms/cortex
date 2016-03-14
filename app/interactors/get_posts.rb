class GetPosts
  include Interactor

  SEARCH_PARAMS = %w{q categories industries type job_phase post_type author}

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
    Array(context.params.keys & SEARCH_PARAMS).length > 0
  end
end
