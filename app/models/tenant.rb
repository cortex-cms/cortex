class Tenant < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  acts_as_nested_set
  acts_as_paranoid

  has_many :applications
  has_many :users
  has_many :active_users, :class_name => 'User', :foreign_key => 'active_tenant_id'
  belongs_to :owner, class_name: "User"

  validates_presence_of :name
  validates_associated :owner

  before_save :init

  def is_organization?
    self.root?
  end

  def has_children?
    !self.leaf?
  end

  private

  def init
    self.subdomain ||= self.name.mb_chars.normalize(:kd).downcase.gsub(/[^a-z0-9]/, '').to_s
  end
end
