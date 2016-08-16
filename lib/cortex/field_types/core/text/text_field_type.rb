class TextFieldType < FieldType
  VALIDATION_TYPES = {
    length: :valid_length_validation?,
    presence: :valid_presence_validation?
  }.freeze

  attr_accessor :data, :text, :field_name
  attr_reader :validations, :metadata

  validates :text, presence: true, if: :validate_presence?
  validate :text_length, if: :validate_length?

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    @text = data_hash.deep_symbolize_keys[:text]
  end

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
  end

  def acceptable_validations?
    valid_types? && valid_options?
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['text']
    json
  end

  def mapping
    {name: mapping_field_name, type: :string, analyzer: :snowball}
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_text"
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

  def valid_length_validation?
    begin
      LengthValidator.new(validations[:length].merge(attributes: [:text]))
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end

  def valid_presence_validation?
    @validations.key? :presence
  end

  def text_present
    errors.add(:text, "must be present") if @text.empty?
  end

  def text_length
    validator = LengthValidator.new(validations[:length].merge(attributes: [:text]))
    validator.validate_each(self, :text, text)
  end

  def validate_presence?
    @validations.key? :presence
  end

  def validate_length?
    @validations.key? :length
  end
end
