class PermissionsRole < ApplicationRecord
  belongs_to :permission
  belongs_to :role
end
