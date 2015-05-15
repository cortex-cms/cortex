module API
  module V1
    module Helpers
      module WebpagesHelper
        def webpage
          @webpage ||= Webpage.find_by_id(params[:id])
        end

        def webpage!
          webpage || not_found!
        end
      end
    end
  end
end
