class TextFieldType < FieldType
  VALIDATION_TYPES = {
    length: :valid_length_validation?,
    presence: :valid_presence_validation?
  }.freeze

  attr_accessor :text, :validations

  validates :text, presence: true, if: :validate_presence?
  validate :text_length, if: :validate_length?

  def initialize(text="", validations={})
    @text = text
    @validations = validations
  end

  def acceptable_validations?
    valid_types? && valid_options?
  end

  private

  def valid_types?
    validations.all? do |type, options|
      VALIDATION_TYPES.include?(type.to_sym)
    end
  end

  def valid_options?
    validations.all? do |type, options|
      self.send(VALIDATION_TYPES[type])
    end
  end

  def valid_length_validation?
    begin
      LengthValidator.new(validations[:length].merge(attributes: [:text]))
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end

  def valid_presence_validation?
    true
  end

  def text_present
    errors.add(:text, "must be present") if @text.empty?
  end

  def text_length
    validator = LengthValidator.new(validations.merge(attributes: [:text]))
    validator.validate_each(self, :text, text)
  end

  def validate_presence?
    return @validations.include?(:presence)
  end

  def validate_length?
    return @validations.include?(:length)
  end
end
