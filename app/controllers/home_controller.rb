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
    flash[:success] = "A new password was successfully sent to your email address."
    redirect_to :index
  end

end
