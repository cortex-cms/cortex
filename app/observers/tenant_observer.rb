class TenantObserver < ActiveRecord::Observer

  def after_create(tenant)
    if tenant.is_organization?
      CreateOrganizationWorker.perform_async(tenant.id)
    end
  end


  def after_delete(tenant)
    if tenant.is_organization?
      DeleteOrganizationWorker.perform_async(tenant.id)
    end
  end

end
