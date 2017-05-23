class GetWebpageFeed
  include Interactor

  def call
    webpage = ::Webpage
    webpage = webpage.find_by_tenant_id(context.tenant) if context.tenant
    webpage = webpage.find_by_protocol_agnostic_url(webpage.protocol_agnostic_url(context.params.url))
    context.webpage = webpage
  end
end
