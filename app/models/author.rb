class Author < ActiveRecord::Base
  include HasGravatar

  scope :published, -> { joins(:posts).where('posts.published_at <= ?', DateTime.now) }

  store_accessor :sites, :personal, :facebook, :twitter, :google
  belongs_to :user
  has_many :posts
end
