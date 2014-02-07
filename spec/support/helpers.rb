module Helpers

  def log_in(factory=nil)
    user = build(factory || :user)
    sign_in(user)
  end
end