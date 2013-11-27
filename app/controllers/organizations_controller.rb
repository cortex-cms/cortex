class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  repond_to :json

  # GET /organizations
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  def show
  end

  # POST /organizations
  def create
    @organization = Organization.new(organization_params)
    repond_with @organization
  end

  # PATCH/PUT /organizations/1
  def update
    respond_with @organization.update(organization_params)
  end

  # DELETE /organizations/1
  def destroy
    @organization.destroy
    respond_with head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name)
    end
end
