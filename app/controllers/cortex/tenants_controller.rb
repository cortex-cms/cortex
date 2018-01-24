require_dependency 'cortex/application_controller'

module Cortex
  class TenantsController < AdminController
    def switch_tenants
      current_user.update(active_tenant: Tenant.find(params[:requested_tenant]))
      respond_to do |format|
        format.json { render :json => current_user.active_tenant }
      end
    end
  end
end
