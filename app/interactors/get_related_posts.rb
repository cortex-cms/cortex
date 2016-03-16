class GetRelatedPosts
  include Interactor

  def call
    related = context.post.related(context.tenant, context.published)

    context.posts = related.page(context.params.page).per(context.params.per_page).records
  end
end
