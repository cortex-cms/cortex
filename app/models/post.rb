class Post < ActiveRecord::Base
  acts_as_taggable
  has_and_belongs_to_many :assets
  has_and_belongs_to_many :categories
  belongs_to :user
end