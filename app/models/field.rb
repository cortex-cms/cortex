class Field < ApplicationRecord
  include BelongsToTenant

  belongs_to :content_type
  has_many :field_items
  has_many :content_items, through: :field_items

  validates :content_type, :field_type, presence: true
  validate :acceptable_field_type
  validates_uniqueness_of :name,
                          scope: :content_type_id,
                          message: 'should be unique within a ContentType'

  def field_type_instance(options={})
    field_type.camelize.constantize.new(options)
  end

  def mapping
    field_type_instance(field_name: name).mapping
  end

  private

  def acceptable_field_type
    begin
      FieldType.get_subtype_constant(field_type)
    rescue NameError
      errors.add(:field_type, 'must be an available field type')
    end
  end
end
