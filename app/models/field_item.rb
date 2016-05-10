class FieldItem < ActiveRecord::Base
  belongs_to :field
  belongs_to :content_item

  validates :content_item_id, :field_id, presence: true
end
