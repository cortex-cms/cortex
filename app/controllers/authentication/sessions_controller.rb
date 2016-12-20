class Authentication::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(_resource)
    if params[:legacy] == '1'
      session[:legacy] = true
      legacy_root_path
    else
      session[:legacy] = false
      root_path
    end
  end
end
