class Contract < ActiveRecord::Base
  has_many :content_types
  has_many :content_decorators, as: :contentable
  has_many :decorators, through: :content_decorators
end
