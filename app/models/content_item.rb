class ContentItem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid

  belongs_to :creator, class_name: "User"
  belongs_to :author, class_name: "User"
  belongs_to :content_type
  has_many :field_items, -> { joins(:field).order("fields.order ASC") }, dependent: :destroy

  accepts_nested_attributes_for :field_items

  validates :creator_id, :author_id, :content_type_id, presence: true

  after_update :update_indexes

  def update_indexes
    __elasticsearch__.client.index(
      { index: content_type.items_index_name,
        type: content_type.items_index_name,
        id: id,
        body: '??????' }
    )
  end
end
