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
    # Do the password reset logic here
    user = User.where(email: params[:user][:email]).first
    if user.present?
      password = Devise.friendly_token.first(8)
      user.update password: password, password_confirmation: password
      PasswordResetMailer.send_password_reset({ email: user.email, password: password }).deliver_now
      flash[:success] = "A new password was successfully sent to your email address."
    else
      flash[:error] = "There's no user on file with that email address."
    end
    redirect_to action: :index
  end

end
