class Category < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :user
  has_and_belongs_to_many :posts
end