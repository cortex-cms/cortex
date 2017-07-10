class GetContentItem
  include Interactor

  def call
    content_item = ::ContentItem
    #content_item = content_item.find_by_tenant_id(context.tenant) if context.tenant
    #content_item = content_item.published if context.published
    #content_item = content_item.find_by_id_or_slug(context.id)
    content_item = content_item.find_by_id(context.id)
    context.content_item = content_item
  end
end
