module API
  module V1
    module Helpers
      module ApplicationsHelper
        def application
          @application ||= Application.find_by_id(params[:id])
        end

        def application!
          application || not_found!
        end
      end
    end
  end
end
