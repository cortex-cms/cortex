class HomeController < ApplicationController
  layout false, only: [:login]
  def index; end
  def login
    respond_to do |format|
      format.text { render 'login.html.haml' }
      format.html
    end
  end
end
