module API
  module V1
    module Helpers
      module LocaleHelper
        def locale
          @locale ||= ::Locale.find_by_id(params[:id])
        end

        def locale!
          locale || not_found!
        end
      end
    end
  end
end
