class UserObserver < ActiveRecord::Observer
  def after_create(user)
    add_author(user)
  end

  def before_destroy(user)
    prevent_consumed_deletion(user)
  end

  private

  def add_author(user)
    user.author = Author.create(user_id: user.id, firstname: user.firstname, lastname: user.lastname, email: user.email)
  end

  def prevent_consumed_deletion(user)
    if user.referenced?
      raise Cortex::Exceptions::ResourceConsumed
    end
  end
end
