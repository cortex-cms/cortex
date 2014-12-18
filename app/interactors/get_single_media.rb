class GetSingleMedia
  include Interactor

  def call
    media = ::Media
    media = media.find_by_tenant_id(context.tenant) if context.tenant
    media = media.find(context.id)
    context.media = media
  end
end
