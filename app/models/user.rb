class User < ActiveRecord::Base
  has_secure_password
  has_many :assets

  validates :password, length: {minimum: 8}, allow_nil: true
end
