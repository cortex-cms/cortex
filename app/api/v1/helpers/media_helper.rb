module API
  module V1
    module Helpers
      module MediaHelper
        def media
          @media ||= ::Media.find_by_id(params[:id])
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
