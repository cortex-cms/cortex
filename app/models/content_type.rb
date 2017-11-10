class ContentType < ApplicationRecord
  include SearchableContentType
  include SearchableContentItemForContentType
  include BelongsToTenant

  validates :name, :creator, :contract, presence: true
  validates_uniqueness_of :name,
                          scope: :tenant_id,
                          message: 'should be unique within a Tenant'

  belongs_to :creator, class_name: 'User'
  belongs_to :contract
  has_many :fields
  has_many :content_items
  has_many :contentable_decorators, as: :contentable
  has_many :decorators, through: :contentable_decorators

  accepts_nested_attributes_for :fields

  # TODO: Extract to a concern
  def self.permissions
    Permission.select { |perm| perm.resource_type = self }
  end

  def name_id # TODO: ContentTypes should have a table-backed name_id field to avoid these collision-prone string manipulations
    name.parameterize(separator: '_')
  end

  # TODO: remove these garbage `_decorator` methods
  def wizard_decorator
    decorators.find_by_name("Wizard")
  end

  def index_decorator
    decorators.find_by_name("Index")
  end

  def rss_decorator
    decorators.find_by_name("Rss")
  end
end
