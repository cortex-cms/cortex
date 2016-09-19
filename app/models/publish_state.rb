class PublishState < ActiveRecord::Base
  belongs_to :content_item

  validates :state, presence: true
end
