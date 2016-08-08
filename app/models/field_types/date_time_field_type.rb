class DateTimeFieldType < FieldType
  VALIDATION_TYPES = {
    presence: :valid_presence_validation?
  }.freeze?

  attr_accessor :data, :timestamp
  attr_reader :validations, :metadata

  validates :timestamp, presence: true, if: :validate_presence?
  validate :timestamp_is_allowed?

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    @values = data_hash.deep_symbolize_keys[:values]
  end

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
  end

  def acceptable_validations?
    valid_types? && valid_options?
  end

  private

  def timestamp_is_allowed?
    begin
      Date.parse(timestamp)
      true
    rescue ArgumentError
      errors.add(:timestamp, 'must be a valid date')
      false
    end
  end

  def valid_types?
    validations.all? do |type, options|
      VALIDATION_TYPES.include?(type)
    end
  end

  def valid_options?
    validations.all? do |type, options|
      self.send(VALIDATION_TYPES[type])
    end
  end

  def valid_presence_validation?
    @validations.key? :presence
  end

  def validate_presence?
    @validations.key? :presence
  end
end