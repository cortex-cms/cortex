class Field < ActiveRecord::Base
  acts_as_paranoid

  include RankedModel
  ranks :order, with_same: :content_type_id

  validates :content_type, :field_type, presence: true
  validate :acceptable_field_type
  validate :acceptable_validations

  belongs_to :content_type

  private

  def acceptable_validations
    if field_type.present?
      field_type_instance = field_type.camelize.constantize.new
      field_type_instance.validations = validations
      errors.add(:validations, "must be for specified type") unless field_type_instance.acceptable_validations?
    end
  end

  def acceptable_field_type
    if field_type.present?
      begin
        field_type.camelize.constantize
      rescue NameError
        errors.add(:field_type, "must be an available field type")
      end
    end
  end
end
