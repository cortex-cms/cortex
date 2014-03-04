class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_tagger

  belongs_to :tenant
  has_many :media
  has_many :tenants
  has_many :posts

  validates_presence_of :email

  def anonymous?
    self.id == nil
  end

  def client_skips_authorization?
    # Yeah, replace with this something serious
    self.email == 'surgeon@careerbuilder.com'
  end

  def profile
    @profile ||= UserProfile.find_by(user_id: self.id) || create_user_profile
  end

  class << self
    def authenticate(username, password)
      user = User.find_by_email(username)
      user && user.valid_password?(password) ? user : nil
    end

    def anonymous
      User.new
    end
  end

  private

  def create_user_profile
    @profile = UserProfile.create(user_id: self.id)
    logger.info "Created UserProfile for <User id=#{self.id}>"
    @profile
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  created_at             :datetime
#  updated_at             :datetime
#  tenant_id              :integer          not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#
