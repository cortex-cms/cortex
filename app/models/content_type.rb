class ContentType < ActiveRecord::Base
  acts_as_paranoid
  validates :name, :creator, presence: true

  belongs_to :creator, class_name: "User"
  has_many :fields, -> { order(order: :asc) }
  has_many :content_items

  accepts_nested_attributes_for :fields
end
