class HomeController < ApplicationController
  def password_reset
  end

  def submit_password_reset
    user = User.where(email: params[:user][:email]).first
    user.send_reset_password_instructions if user.present?
    flash[:success] = 'If you entered a valid email address, instructions on resetting your password will be emailed to you.'
    redirect_to action: :index
  end
end
