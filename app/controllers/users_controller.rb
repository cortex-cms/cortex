class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  respond_to :json

  # GET /users
  def index
    @users = User.all
    respond_with @users
  end

  # GET /users/1
  def show
  end

  # GET /users/me
  def me
    @user = @current_user
    render :show
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.save
    respond_with @user
  end

  # PATCH/PUT /users
  def update
    @user.update(user_params)
    respond_with @user
  end
  
  # DELETE /users/1
  def destroy
    @user.destroy
    respond_with @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
end
