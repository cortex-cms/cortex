class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  validates :name, :resource_type, presence: true

  def resource
    resource_type.constantize
  end
end
