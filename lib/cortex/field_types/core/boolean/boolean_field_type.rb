class BooleanFieldType < FieldType
  VALIDATION_TYPES = {
    presence: :valid_presence_validation?
  }.freeze

  attr_accessor :data, :value, :field_name
  attr_reader :validations, :metadata

  validates :value, presence: true, if: :validate_presence?
  validate :value_is_allowed?

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    @value = data_hash.deep_symbolize_keys[:value]
  end

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
  end

  def acceptable_validations?
    valid_types? && valid_options?
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['boolean']
    json
  end

  def mapping
    {name: mapping_field_name, type: :string, analyzer: :snowball}
  end

  private

  def mapping_field_name
    "#{field_name.downcase.gsub(' ', '_')}_boolean"
  end

  def value_is_allowed?
    if [true, false].include?(value)
      true
    else
      errors.add(:value, "must be True or False")
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
