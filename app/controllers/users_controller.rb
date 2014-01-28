class UsersController < ApplicationController
  respond_to :json

  # GET /users/me
  def me
    @user = current_user
    render :show
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
