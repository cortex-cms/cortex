class TextFieldType
  include ActiveModel::Validations

  VALIDATION_TYPES = [
    :length,
    :presence
  ]

  validate :text_present, if: :validate_presence?
  validate :text_length, if: :validate_length?

  def initialize(text, validations)
    @text = text
    @validations = validations
  end

  private

  def text_present
    errors.add(:text, "must be present") if @text.empty?
  end

  def text_length
    errors.add(:text, "must be no more than #{@validations[:length]} characters") unless (@text.length <= @validations[:length])
  end

  def validate_presence?
    return @validations.include?(:presence)
  end

  def validate_length?
    return @validations.include?(:length)
  end
end
