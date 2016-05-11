class ContentType < ActiveRecord::Base
  acts_as_paranoid
  validates :name, :creator, presence: true

  belongs_to :creator, class_name: "User"
  has_many :fields
end
