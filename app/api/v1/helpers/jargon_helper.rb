module API
  module V1
    module Helpers
      module JargonHelper
        def jargon
          @jargon ||= Jargon::Client.new(key: Cortex.config.jargon.client_id,
                                         secret: Cortex.config.jargon.client_secret,
                                         base_url: Cortex.config.jargon.site_url)
        end
      end
    end
  end
end
