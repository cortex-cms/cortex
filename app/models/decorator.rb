class Decorator < ActiveRecord::Base
  has_many :contentable_decorators

  validates :name, :data, presence: true
end
