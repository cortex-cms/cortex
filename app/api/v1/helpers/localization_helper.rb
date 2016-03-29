module V1
  module Helpers
    module LocalizationHelper
      def localization
        @localization ||= ::Localization.find_by_id(params[:id])
      end

      def localization!
        localization || not_found!
      end
    end
  end
end
