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

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    values = data_hash.deep_symbolize_keys[:values]
    @values = values.select { |kv| values[kv] == "1" }.keys unless values.nil?
  end

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys.extend(Hashie::Extensions::DeepLocate)
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

  def minimum
    # unless @values.nil?
    #   if @values.length >= @validations[:maximum]
    #     true
    #   else
    #     errors.add(:minimum, "You have selected too few values.")
    #     false
    #   end
    # end
    true
  end

  def maximum
    # unless @values.nil?
    #   if @values.length <= @validations[:maximum]
    #     true
    #   else
    #     errors.add(:maximum, "You have selected too many values.")
    #     false
    #   end
    # end
    true
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
