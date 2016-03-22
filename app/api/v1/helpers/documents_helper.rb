module V1
  module Helpers
    module DocumentsHelper
      def document
        @document ||= Document.find_by_id(params[:id])
      end

      def document!
        document || not_found!
      end
    end
  end
end
