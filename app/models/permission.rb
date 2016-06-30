class Permission < ActiveRecord::Base
  has_many :role_permissions
  has_many :roles, through: :role_permissions

  validates :name, :resource_type, presence: true

  def resource
    resource_type
  end
  
end
