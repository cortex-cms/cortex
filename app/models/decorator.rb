class Decorator < ApplicationRecord
  has_many :contentable_decorators

  validates :name, :data, presence: true
end
