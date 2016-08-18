class Decorator < ActiveRecord::Base
  has_many :contentable_decorators

  validates :type, :data, presence: true
end
