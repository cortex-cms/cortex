class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  respond_to :json

  # GET /posts
  def index
    @posts = Post.all
    respond_with @posts
  end

  # GET /posts/1
  def show
    respond_with @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = @current_user
    @post.save!
    respond_with @post
  end

  # PATCH/PUT /posts/1
  def update
    @post.update(post_params)
    respond_with @post
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_with head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:title, :type, :published_at, :expired_at, :deleted_at, :draft, :body, :short_description, :job_phase, :display, :featured_image_url, :notes, :copyright_owner, :seo_title, :seo_description, :seo_preview, :category_ids, :author)
    end
end
