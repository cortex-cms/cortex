class FieldItem < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :field
  belongs_to :content_item

  validates :field_id, presence: true
  validates :content_item_id, presence: true, on: :update
  validate :field_item_content_is_valid

  private

  def field_item_content_is_valid
    errors.add(:data, "must be valid") unless field_item_validates
  end

  def field_item_validates
    field_type_class = FieldType.get_constant(field.field_type)
    field_type_instance = field_type_class.new(data, field.validations)
    field_type_instance.valid?
  end
end
