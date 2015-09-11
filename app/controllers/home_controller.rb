class HomeController < ApplicationController
  layout false, only: [:login]
  def index; end
  def login
    respond_to do |format|
      format.text { render 'login.html.haml' }
      format.html
    end
  end

  def password_reset; end
  def submit_password_reset
    user = User.where(email: params[:user][:email]).first
    if user.present?
      password = Devise.friendly_token.first(8)
      user.update password: password, password_confirmation: password
      PasswordResetMailer.send_password_reset({ email: user.email, password: password }).deliver_later
      flash[:success] = "A new password will be sent to #{user.email}"
    else
      flash[:error] = "There's no user on file with that email address"
    end
    redirect_to action: :index
  end
end
