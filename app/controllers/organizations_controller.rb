class OrganizationsController < ApplicationController
  respond_to :json

  # GET /organizations
  def index
    @organizations = Tenant.roots
  end
end
