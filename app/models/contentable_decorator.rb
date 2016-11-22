class ContentableDecorator < ApplicationRecord
  belongs_to :decorator
  belongs_to :contentable, polymorphic: true
end
