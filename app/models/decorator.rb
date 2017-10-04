class Decorator < ApplicationRecord
  include BelongsToTenant

  has_many :contentable_decorators

  validates :name, :data, presence: true
end
