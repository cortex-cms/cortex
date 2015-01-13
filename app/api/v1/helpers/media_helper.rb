module API
  module V1
    module Helpers
      module MediaHelper
        def media
          @media ||= ::GetSingleMedia.call(id: params[:id], tenant: current_tenant.id).media
        end

        def media!
          media || not_found!
        end

        def media_params
          clean_params(params)
        end
      end
    end
  end
end
