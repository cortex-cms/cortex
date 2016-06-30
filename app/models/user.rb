require 'digest/md5'

class User < ActiveRecord::Base
  include HasGravatar
  include HasFirstnameLastname
  include SearchableUser
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :recoverable
  acts_as_tagger
  rolify

  belongs_to :tenant
  has_one    :author
  has_many   :media
  has_many   :tenants
  has_many   :posts, through: :authors
  has_many   :localizations
  has_many   :locales
  has_many   :role_permissions, through: :roles
  has_many   :permissions, through: :role_permissions

  validates_presence_of :email, :tenant, :firstname, :lastname

  scope :tenantUsers, -> (tenant_id) { where(tenant_id: tenant_id) }

  def referenced?
    [Media, Post, Locale, Localization, BulkJob].find do |resource|
      true if resource.where(user: self).count > 0
    end
  end

  def anonymous?
    self.id == nil
  end

  def has_permission?(resource, permission)
    return true if @user.is_superadmin?

    resource_class = resource.class
    allowed_perms = allowed_permissions(resource_class, permission)

    if resource_class == ContentType
      allowed_perms.select { |perm| perm.resource_id == resource.id }.any?
    else
      allowed_perms.any?
    end
  end

  def is_admin?
    self.admin
  end

  def client_skips_authorization?
    # Yeah, replace this with something serious
    self.email == 'surgeon@cbcortex.com' || 'surgeon@careerbuilder.com'
  end

  def to_json(options={})
    options[:only] ||= %w(id email created_at updated_at tenant_id firstname lastname admin)
    options[:methods] ||= %w(fullname)
    super(options)
  end

  def gravatar
    "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest email}"
  end

  private

  def allowed_permissions(resource_class, permission)
    permissions.select { |perm| perm.resource_type == resource_class.to_s && perm.name == permission }
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
end
