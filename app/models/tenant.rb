class Tenant < ApplicationRecord
  acts_as_nested_set
  acts_as_paranoid

  has_many :content_items
  has_many :content_types
  has_many :users, foreign_key: :active_tenant_id, class_name: 'User'
  has_and_belongs_to_many :users
  belongs_to :owner, class_name: 'User'

  validates_presence_of :name
  validates_associated :owner

  alias_method :organization, :root

  def is_organization?
    self.root?
  end

  def has_children?
    !self.leaf?
  end
end
