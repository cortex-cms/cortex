require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_many :assets

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def User.authenticate(username, password)
    user = User.find_by_name(username)
    return user if user and user.password == password
  end
end
