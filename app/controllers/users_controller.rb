class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    @users = User.all
    respond_with @users
  end

  def show
  end

  def me
    @user = @current_user
    render :show
  end

  def new
    respond_with User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with @user
  end

  def update
    @user.update(user_params)
    respond_with @user
  end

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
      params.require(:user).permit(:name, :password)
    end
end
