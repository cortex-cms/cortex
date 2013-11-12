class PlatformAdminsController < ApplicationController
  before_action :set_platform_admin, only: [:show, :edit, :update, :destroy]

  # GET /platform_admins
  # GET /platform_admins.json
  def index
    @platform_admins = PlatformAdmin.all
  end

  # GET /platform_admins/1
  # GET /platform_admins/1.json
  def show
  end

  # GET /platform_admins/new
  def new
    @platform_admin = PlatformAdmin.new
  end

  # GET /platform_admins/1/edit
  def edit
  end

  # POST /platform_admins
  # POST /platform_admins.json
  def create
    @platform_admin = PlatformAdmin.new(platform_admin_params)

    respond_to do |format|
      if @platform_admin.save
        format.html { redirect_to @platform_admin, notice: 'Platform admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @platform_admin }
      else
        format.html { render action: 'new' }
        format.json { render json: @platform_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /platform_admins/1
  # PATCH/PUT /platform_admins/1.json
  def update
    respond_to do |format|
      if @platform_admin.update(platform_admin_params)
        format.html { redirect_to @platform_admin, notice: 'Platform admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @platform_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platform_admins/1
  # DELETE /platform_admins/1.json
  def destroy
    @platform_admin.destroy
    respond_to do |format|
      format.html { redirect_to platform_admins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform_admin
      @platform_admin = PlatformAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_admin_params
      params.require(:platform_admin).permit(:user_id, :organization_id)
    end
end
