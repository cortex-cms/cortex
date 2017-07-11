class Document < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :snippets
  has_many :webpages, through: :snippets

  validates_presence_of :user
end
