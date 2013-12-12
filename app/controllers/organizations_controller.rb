class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]
  respond_to :json

  # GET /organizations
  def index
    @organizations = Tenant.roots
  end

  # GET /organizations/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Tenant.roots.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:tenant).permit(:name, :parent_id, :contact_name, :contact_email, :contact_phone, :active_at, :deactive_at, :contract, :did, :subdomain)
    end
end
