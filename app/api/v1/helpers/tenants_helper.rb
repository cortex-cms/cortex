module API
  module V1
    module Helpers
      module TenantsHelper
        def tenant
          @tenant ||= Tenant.find_by_id(params[:id])
        end

        def tenant!
          tenant || not_found!
        end

        def tenant_params
          clean_params(params)
        end
      end
    end
  end
end
