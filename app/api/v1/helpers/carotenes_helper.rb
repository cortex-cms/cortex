module V1
  module Helpers
    module CarotenesHelper
      def carotene
        @carotene ||= Carotene.find_by_id(params[:id])
      end

      def carotene!
        carotene || not_found!
      end
    end
  end
end
