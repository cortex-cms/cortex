class TreeFieldType < FieldType
  VALIDATION_TYPES = {
    presence: :valid_presence_validation?,
    maximum: :valid_maximum_validation?,
    minimum: :valid_minimum_validation?
  }.freeze

  attr_accessor :data, :values, :field_name
  attr_reader :validations, :metadata

  validates :values, presence: true, if: :validate_presence?
  validate  :minimum, if: :validate_minimum?
  validate  :maximum, if: :validate_maximum?
  validate  :value_is_allowed?

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

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['tree']
    json
  end

  def mapping
    { name: mapping_field_name, type: :string, analyzer: :snowball }
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_tree"
  end

  def value_is_allowed?
    @values.each do |value|
      if Tree.gather_ids(@metadata[:allowed_values]).include?(value)
        true
      else
        errors.add(:value, "must be allowed.")
        false
      end
    end
  end

  def minimum
    if @values.length >= @validations[:maximum]
      true
    else
      errors.add(:minimum, "You have selected too few values.")
      false
    end
  end

  def maximum
    if @values.length <= @validations[:maximum]
      true
    else
      errors.add(:maximum, "You have selected too many values.")
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

  def valid_maximum_validation?
    @validations.key? :maximum
  end

  def valid_minimum_validation?
    @validations.key? :minimum
  end

  def validate_presence?
    @validations.key? :presence
  end

  def validate_minimum?
    @validations.key? :minimum
  end

  def validate_maximum?
    @validations.key? :maximum
  end

end
