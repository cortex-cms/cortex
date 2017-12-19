class Document < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :snippets
  has_many :webpages, through: :snippets
  after_update { webpages.find_each(&:touch) }
  after_save { webpages.find_each(&:touch) }
end
