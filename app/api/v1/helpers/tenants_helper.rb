module API::V1
  module Helpers
    module TenantsHelper
      def tenant
        @tenant ||= Tenant.find_by_id(params[:id])
      end

      def tenant!
        tenant || not_found!
      end
    end
  end
end
