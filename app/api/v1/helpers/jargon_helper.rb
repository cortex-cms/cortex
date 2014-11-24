module API
  module V1
    module Helpers
      module JargonHelper
        def localization_service
          @localization ||= ::LocalizationService.new(params[:id])
        end
      end
    end
  end
end
