module V1
  module Helpers
    module SnippetsHelper
      def snippet
        @snippet ||= Snippet.find_by_id(params[:id])
      end

      def snippet!
        snippet || not_found!
      end
    end
  end
end
