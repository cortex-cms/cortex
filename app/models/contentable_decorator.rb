class ContentableDecorator < ActiveRecord::Base
  belongs_to :decorator
  belongs_to :contentable, polymorphic: true
end
