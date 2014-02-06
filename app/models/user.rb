class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_tagger

  belongs_to :tenant
  has_many :assets
  has_many :tenants
  has_many :posts

  validates_presence_of :email

  def self.authenticate(username, password)
    user = User.find_by_name(username)
    return user if user && user.authenticate(password)
  end
end
