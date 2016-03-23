require 'uri'

class CacheBustWebpageJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    r = Excon.get(get_cache_buster_url(url))
    raise "Error while executing cache buster request\nStatus: #{r.status}\nBody: #{r.body}" if r.status >= 300
  end

  private

  def get_cache_buster_url(url)
    root_domain_uri = URI.parse(url)
    "#{root_domain_uri.scheme}://#{root_domain_uri.host}/cache?path=#{URI.encode(root_domain_uri.path)}"
  end
end
