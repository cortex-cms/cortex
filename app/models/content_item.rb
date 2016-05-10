class ContentItem < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :author, class_name: "User"
  belongs_to :content_type

  validates :creator_id, :author_id, :content_type_id, presence: true
end
