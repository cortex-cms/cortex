class Tenant < ActiveRecord::Base
  default_scope { where(deleted_at: nil) }

  acts_as_nested_set
  acts_as_paranoid

  has_many :applications
  has_many :users
  belongs_to :owner, class_name: "User"

  validates_presence_of :name
  validates_associated :owner

  def is_organization?
    self.root?
  end

  def has_children?
    !self.leaf?
  end
end
