class CacheBustWebpageJob < ApplicationJob
  queue_as :default

  def perform(url)
    r = Excon.get(get_cache_buster_url(url))
    raise "Error while executing cache buster request\nStatus: #{r.status}\nBody: #{r.body}" if r.status >= 300
  end

  private

  def get_cache_buster_url(url)
    uri = Addressable::URI.parse(url)
    "#{uri.scheme}://#{uri.authority}/cache?path=#{Addressable::URI.encode(uri.path)}"
  end
end
