class AuthenticationFailure < Devise::FailureApp
  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
