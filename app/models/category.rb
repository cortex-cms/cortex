class Category < ApplicationRecord
  acts_as_nested_set
  scope :job_phases, -> { where(depth: 0) }
  scope :categories, -> { where(depth: 1) }

  belongs_to :user
  has_and_belongs_to_many :posts

  validates_presence_of :user
end
