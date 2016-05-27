class Field < ActiveRecord::Base
  acts_as_paranoid

  include RankedModel
  ranks :order, with_same: :content_type_id

  belongs_to :content_type
  has_many :field_items
  has_many :content_items, through: :field_items

  validates :content_type, :field_type, presence: true
  validate :acceptable_field_type, if: :field_type_is_present
  validate :acceptable_validations, if: :field_type_is_present

  private

  def field_type_is_present
    field_type.present?
  end

  def acceptable_validations
    field_type_class = FieldType.get_subtype_constant(field_type)
    field_type_instance = field_type_class.new({}, validations)
    errors.add(:validations, "must be for specified type") unless field_type_instance.acceptable_validations?
  end

  def acceptable_field_type
    begin
      FieldType.get_subtype_constant(field_type)
    rescue NameError
      errors.add(:field_type, "must be an available field type")
    end
  end
end
