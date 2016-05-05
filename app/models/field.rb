class Field < ActiveRecord::Base
  include RankedModel
  ranks :order, with_same: :content_type_id

  validates :content_type, :field_type, presence: true

  belongs_to :content_type
end