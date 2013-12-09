class User < ActiveRecord::Base
  has_secure_password
  acts_as_tagger
  has_many :assets
  has_many :tenants

  validates :password, length: {minimum: 8}, allow_nil: true

  def User.authenticate(username, password)
    user = User.find_by_name(username)
    return user if user && user.authenticate(password)
  end
end
