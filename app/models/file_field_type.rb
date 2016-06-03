class FileFieldType < FieldType
  VALIDATION_TYPES = {
    presence: :valid_presence_validation?,
    size: :valid_size_validation?,
    content_type: :valid_content_type_validation?
  }.freeze

  has_attached_file :document
  do_not_validate_attachment_file_type :document

  validates :document, attachment_presence: true, if: :validate_presence?


  attr_accessor :document,
                :document_file_name,
                :document_content_type,
                :document_file_size,
                :document_updated_at,
                :id

  attr_reader :validations

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    @document = data_hash.deep_symbolize_keys[:document]
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

  def valid_presence_validation?
    @validations.key? :presence
  end

  def validate_presence?
    @validations.key? :presence
  end

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
