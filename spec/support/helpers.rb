module Helpers

  def log_in(factory=nil)
    user = build(factory || :user)
    log_in_user(user)
  end

  def log_in_user(user)
    controller.log_in(user)
  end
end