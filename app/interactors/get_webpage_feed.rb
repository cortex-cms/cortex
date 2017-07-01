class GetWebpageFeed
  include Interactor

  def call
    webpage = ::Webpage
    webpage = webpage.find_by_tenant_id(context.tenant) if context.tenant
    webpage = webpage.agnostic_find_by_url(context.params.url).first
    context.webpage = webpage
  end
end
