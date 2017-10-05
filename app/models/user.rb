require 'digest/md5'

class User < ApplicationRecord
  include HasGravatar
  include HasFirstnameLastname

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :recoverable
  rolify role_join_table_name: :roles_users # rolify doesn't obey lexical order for join table names

  has_and_belongs_to_many :tenants
  belongs_to :active_tenant, class_name: 'Tenant'
  has_many :content_items

  validates_presence_of :email, :firstname, :lastname

  before_destroy :prevent_consumed_deletion

  def active_tenant
    super || tenants.order(:name).first
  end

  def referenced?
    [ContentItem].find do |resource|
      true if resource.where(user: self).count > 0
    end
  end

  def anonymous?
    self.id == nil
  end

  def has_permission?(resource, permission)
    return true if self.is_superadmin?

    resource_class = resource.class
    allowed_perms = allowed_permissions(resource_class, permission)

    if resource_class == ContentType
      allowed_perms.select {|perm| perm.resource_id == resource.id}.any?
    else
      allowed_perms.any?
    end
  end

  def gravatar
    "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest email}"
  end

  def tenants_with_children
    tenants.flat_map(&:self_and_descendants)
  end

  private

  def allowed_permissions(resource_class, permission)
    permissions.select {|perm| perm.resource_type == resource_class.to_s && perm.name == permission}
  end

  def prevent_consumed_deletion
    raise Cortex::Exceptions::ResourceConsumed if referenced?
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
