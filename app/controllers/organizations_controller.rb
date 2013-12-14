class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]
  respond_to :json

  # GET /organizations
  def index
    @organizations = Tenant.roots
  end

  # GET /organizations/1
  def show
    @organization = Tenant.roots.find(params[:id])
  end

  private
    def organization_params
      params.require(:tenant).permit(:name, :parent_id, :contact_name, :contact_email, :contact_phone, :active_at, :deactive_at, :contract, :did, :subdomain)
    end
end
