class Author < ActiveRecord::Base
  include HasGravatar
  include HasFirstnameLastname

  scope :published, -> { joins(:posts).where('authors.user_id IS NOT NULL AND posts.published_at <= ?', DateTime.now) }

  store_accessor :sites, :personal, :facebook, :twitter, :google
  belongs_to :user
  has_many :posts
end
