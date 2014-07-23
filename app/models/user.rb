class User < ActiveRecord::Base
  include HasGravatar
  include HasFirstnameLastname
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_tagger

  belongs_to :tenant
  has_one :author
  has_many :media
  has_many :tenants
  has_many :posts, through: :authors

  after_create :add_author

  validates_presence_of :email

  def anonymous?
    self.id == nil
  end

  def is_admin?
    self.admin
  end

  def client_skips_authorization?
    # Yeah, replace with this something serious
    self.email == 'surgeon@careerbuilder.com'
  end

  def profile
    @profile ||= UserProfile.find_or_create_by(:user_id => self.id)
  end

  def to_json(options={})
    options[:only] ||= %w(id email created_at updated_at tenant_id firstname lastname)
    options[:methods] ||= %w(fullname)
    super(options)
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

  def add_author
    author = Author.create(user_id: id, firstname: firstname, lastname: lastname, email: email)
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
#  firstname              :string(255)      not null
#  lastname               :string(255)
#  locale                 :string(30)       default("en_US"), not null
#  timezone               :string(30)       default("EST"), not null
#  admin                  :boolean          default(FALSE), not null
#
