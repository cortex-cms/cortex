class TenantsController < AdminController
  def switch_tenants
    respond_to do |format|
      format.json { render :json => {name: '大姐'} }
    end
  end
end
