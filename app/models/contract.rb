# TODO: Refactor
class Contract < ApplicationRecord
  include BelongsToTenant

  has_many :content_types
  has_many :contentable_decorators, as: :contentable
  has_many :decorators, through: :contentable_decorators
end
