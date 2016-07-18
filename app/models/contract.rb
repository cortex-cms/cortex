class Contract < ActiveRecord::Base
  has_many :decorators, as: :viewable
  has_many :content_types
end
