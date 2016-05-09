class TextFieldType < FieldType
  VALIDATION_TYPES = [
    :length,
    :presence
  ]

  validate :text_present, if: :validate_presence?
  validate :text_length, if: :validate_length?

  class << self
    def acceptable_validations?(requested_validations)
      valid_types?(requested_validations) && valid_options?(requested_validations)
    end
    
    private

    def valid_types?(requested_validations)
      requested_validations.all? do |type, options|
        VALIDATION_TYPES.include?(type.to_sym)
      end
    end

    def valid_options?(requested_validations)
      requested_validations.all? do |type, options|
        self.send("check_#{type}_options", options)
      end
    end

    def check_presence_options(options)
      true
    end

    def check_length_options(options)
      true if options.is_a? Integer
    end
  end


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
