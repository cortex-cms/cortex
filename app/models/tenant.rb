class Tenant < ActiveRecord::Base
  default_scope { where(deleted_at: nil) }
  acts_as_nested_set
  acts_as_paranoid

  belongs_to :user
  has_and_belongs_to_many :posts

  validates_presence_of :name
  validates_associated :user

  def is_organization?
    self.root?
  end

  def has_children?
    !self.leaf?
  end
end
