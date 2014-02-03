class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_secure_password
  acts_as_tagger

  belongs_to :tenant
  has_many :assets
  has_many :tenants
  has_many :posts

  validates :password, length: {minimum: 8}, allow_nil: true
  validates_presence_of :name
  validates_presence_of :email

  def self.authenticate(username, password)
    user = User.find_by_name(username)
    return user if user && user.authenticate(password)
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(30)       not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  tenant_id       :integer          not null
#
