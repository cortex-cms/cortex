class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :update, :destroy]
  respond_to :json, :multipart_form

  # GET /assets
  def index
    @assets = Asset.all
    respond_with @assets
  end

  # GET /assets/1
  def show
    respond_with @asset
  end

  # POST /assets
  def create
    respond_with Asset.create(asset_params)
  end

  # PATCH/PUT /assets/1
  def update
    @asset.update(asset_params)
    respond_with @asset
  end

  # DELETE /assets/1
  def destroy
    @asset.destroy
    respond_with head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:name, :deleted_at, :file)
    end
end
