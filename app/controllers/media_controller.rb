class MediaController < ApplicationController
  before_action :set_media, only: [:show, :update, :destroy]

  respond_to :json, :multipart_form

  include Paginated

  # GET /media
  def index
    @media = Media.order(created_at: :desc).page(page).per(per_page)
    set_pagination_results(Media, @media)
    respond_with @media
  end

  # GET /media/1
  def show
    respond_with @media
  end

  # GET /media/search
  def search

    total_count = 0
    q = params[:q]
    if q.to_s != ''
      # Search with ES if query provided
      @media = Media.search :load => {:include => %w(user tags)}, :page => page, :per_page => per_page do
        query { string q }
        sort { by :created_at, :desc }
      end
      total_count = @media.total_count
    else
      @media = Media.order(created_at: :desc).page(page).per(per_page)
      total_count = Media.count
    end

    set_pagination_results(Media, @media, total_count)

    render :index
  end

  # POST /media
  def create
    @media = Media.new(media_params)
    @media.user = current_user
    @media.save!
    respond_with @media
  end

  # PATCH/PUT /media/1
  def update
    @media.update(media_params)
    if params[:tag_list]
      @media.tag_list = params[:tag_list]
      @media.save!
    end
    respond_with @media
  end

  # DELETE /media/1
  def destroy
    @media.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media
      @media = Media.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_params
      params.require(:media).permit(:name, :attachment, :description, :alt, :active, :deactive_at, :tag_list)
    end
end
