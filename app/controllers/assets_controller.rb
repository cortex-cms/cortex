class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :update, :destroy]
  respond_to :json, :multipart_form

  include Paginated

  # GET /assets
  def index
    @assets = Asset.page(page).per(per_page)
    set_pagination_results(Asset, @assets)
    respond_with @assets
  end

  # GET /assets/1
  def show
    respond_with @asset
  end

  # GET /assets/search
  def search
    if params[:q].to_s.strip.length == 0
      @assets = Asset.page(page).per(per_page).all
      set_pagination_results(Asset, @assets)
    else
      @assets = Asset.search(params[:q], load: true, :page => page, :per => per_page)
      set_pagination_results(Asset, @assets, @assets.total_count)
    end

    render :index
  end

  # POST /assets
  def create
    @asset = Asset.new(asset_params)
    @asset.user = @current_user
    @asset.save!
    respond_with @asset
  end

  # PATCH/PUT /assets/1
  def update
    @asset.update(asset_params)
    if params[:tag_list]
      @asset.tag_list = params[:tag_list]
      @asset.save!
    end
    respond_with @asset
  end

  # DELETE /assets/1
  def destroy
    @asset.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:name, :attachment, :description, :alt, :active, :deactive_at, :tag_list)
    end
end
