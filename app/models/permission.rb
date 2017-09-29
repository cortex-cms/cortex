class Permission < ApplicationRecord
  has_many :permissions_roles
  has_many :roles, through: :permissions_roles

  validates :name, :resource_type, presence: true

  def resource
    resource_type.constantize
  end
end
