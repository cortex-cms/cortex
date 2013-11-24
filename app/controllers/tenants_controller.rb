class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /tenants
  # GET /tenants.json
  def index
    @tenants = Tenant.all
  end

  def hierarchy
    @tenants = Tenant.roots
  end

  def by_organization
    @tenants = Organization.find(params[:org_id]).tenants
    render :index
  end

  def hierarchy_by_organization
    @tenants = Tenant.roots.where(organization_id: params[:org_id])
    render :hierarchy
  end

  # GET /tenants/1
  # GET /tenants/1.json
  def show
  end

  # POST /tenants
  # POST /tenants.json
  def create
    respond_with Tenant.new(tenant_params)
  end

  # PATCH/PUT /tenants/1
  # PATCH/PUT /tenants/1.json
  def update
    respond_with @tenant.update(tenant_params)
  end

  # DELETE /tenants/1
  # DELETE /tenants/1.json
  def destroy
    @tenant.destroy
    respond_with head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tenant_params
      params.require(:tenant).permit(:name, :parent_id, :contact_name, :contact_email, :contact_phone, :active_at, :inactive_at, :contract, :did)
    end
end
