module API
  module V1
    module Helpers
      module LocalizationHelper
        def localization
          @localization ||= jargon.localizations(params[:id]).get
        end

        def localization!
          localization.status == 404 ? not_found! : localization
        end
      end
    end
  end
end
