class GetPost
  include Interactor

  def call
    post = ::Post
    post = post.find_by_tenant_id(context.tenant) if context.tenant
    post = post.published if context.published
    post = post.find_by_id_or_slug(context.id)
    context.post = post
  end
end
