class UserObserver < ActiveRecord::Observer
  def after_create(user)
    add_author(user)
  end

  private

  def add_author(user)
    user.author = Author.create(user_id: user.id, firstname: user.firstname, lastname: user.lastname, email: user.email)
  end
end
