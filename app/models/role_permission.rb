class RolePermission < ApplicationRecord
  belongs_to :role
  belongs_to :permission
end
