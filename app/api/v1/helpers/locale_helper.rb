module API
  module V1
    module Helpers
      module LocaleHelper
        def locale
          @locale ||= jargon.localizations(params[:localization_id]).get_locale(params[:id])
        end

        def locale!
          locale.status == 404 ? not_found! : locale
        end
      end
    end
  end
end
