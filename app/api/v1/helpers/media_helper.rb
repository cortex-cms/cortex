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
      end
    end
  end
end
