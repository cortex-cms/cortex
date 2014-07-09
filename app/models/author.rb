class Author < ActiveRecord::Base
  include HasGravatar
  store_accessor :sites, :personal, :facebook, :twitter, :google
  belongs_to :user
  has_many :posts
end
