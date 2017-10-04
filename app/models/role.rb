class Role < ApplicationRecord
  scopify

  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true
end
