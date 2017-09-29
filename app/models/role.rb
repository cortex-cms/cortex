class Role < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :permissions_roles
  has_many :permissions, through: :permissions_roles

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify
end
