class GetPosts
  include Interactor

  SEARCH_PARAMS = %w(q categories industries type job_phase post_type author tags carotene_code).freeze

  def call
    posts = ::Post

    if has_search_params?
      posts = posts.search_with_params(context.params, context.tenant, context.published)
    else
      posts = posts.show_all(context.tenant, context.published, context.scheduled)
    end

    context.posts = posts
  end

  private

  def has_search_params?
    (context.params.to_h.keys & SEARCH_PARAMS).any?
  end
end
