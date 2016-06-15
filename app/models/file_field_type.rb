class FileFieldType < FieldType
  VALIDATION_TYPES = {
    presence: :valid_presence_validation?,
    size: :valid_size_validation?,
    content_type: :valid_content_type_validation?
  }.freeze

  attr_accessor :document_file_name,
                :document_content_type,
                :document_file_size,
                :document_updated_at

  attr_reader :data, :validations

  has_attached_file :document
  do_not_validate_attachment_file_type :document

  validates :document, attachment_presence: true, if: :validate_presence?

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    self.document = data_hash.deep_symbolize_keys[:document]
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

  def validate_presence?
    @validations.key? :presence
  end

  alias_method :valid_presence_validation?, :validate_presence?

  def valid_size_validation?
    begin
      AttachmentSizeValidator.new(validations[:size].merge(attributes: :document))
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end

  def valid_content_type_validation?
    begin
      AttachmentContentTypeValidator.new(validations[:content_type].merge(attributes: :document))
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end
end
