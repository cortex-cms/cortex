class GetWebpageFeed
  include Interactor

  def call
    webpage = ::Webpage
    webpage = webpage.find_by_tenant_id(context.tenant) if context.tenant
    webpage = webpage.find_by_protocol_agnostic_url(protocol_agnostic_url(context.params.url))
    context.webpage = webpage
  end

  private

  def protocol_agnostic_url(url)
    uri = Addressable::URI.parse(url)
    path = uri.path == '/' ? uri.path : uri.path.chomp('/')
    "://#{uri.authority}#{path}"
  end
end
