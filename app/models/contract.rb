class Contract < ApplicationRecord
  # TODO: Refactor
  has_many :content_types
  has_many :contentable_decorators, as: :contentable
  has_many :decorators, through: :contentable_decorators
end
