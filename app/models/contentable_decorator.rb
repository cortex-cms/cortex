class ContentableDecorator < ApplicationRecord
  include BelongsToTenant

  belongs_to :decorator
  belongs_to :contentable, polymorphic: true
end
