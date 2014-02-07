class TenantsController < ApiController
  before_action :set_tenant, only: [:show, :update, :destroy]
  before_action :set_tenants, only: [:tenant_tenants, :tenant_hierarchy]

  respond_to :json

  # GET /tenants
  def index
    @tenants = params[:roots_only] ? Tenant.roots : Tenant.all
  end

  # GET /tenants/hierarchy
  def hierarchy
    @tenants = Tenant.roots
  end

  # GET /tenants/:id/tenants
  def tenant_tenants
    render :index
  end

  # GET /tenants/:id/hierarchy
  def tenant_hierarchy
    render :hierarchy
  end

  # GET /tenants/1
  def show
    respond_with @tenant
  end

  # POST /tenants
  def create
    @tenant = Tenant.new(tenant_params)
    @tenant.user = @current_user
    @tenant.save!
    respond_with @tenant
  end

  # PATCH/PUT /tenants/1
  def update
    respond_with @tenant.update(tenant_params)
  end

  # DELETE /tenants/1
  def destroy
    if @tenant.has_children?
      raise(Exceptions::NotEmptyError, 'Tenant still has children which must be removed before deletion.')
    end

    @tenant.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    def set_tenants
      @tenants = params[:include_root] ? [Tenant.find(params[:id])] : Tenant.find(params[:id]).children
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tenant_params
      params.require(:tenant).permit(:name, :parent_id, :contact_name, :contact_email, :contact_phone, :active_at, :deactive_at, :contract, :did, :subdomain)
    end
end
