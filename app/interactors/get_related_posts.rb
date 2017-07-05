class GetRelatedPosts
  include Interactor

  def call
    related = context.post.related(context.tenant, context.published)

    context.posts = related.records
  end
end
