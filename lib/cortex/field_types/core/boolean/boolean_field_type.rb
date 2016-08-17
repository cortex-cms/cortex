class BooleanFieldType < FieldType
  attr_accessor :data, :value, :field_name
  attr_reader :validations, :metadata

  def validations=(validations_hash)
    @validations = {}
  end

  def data=(data_hash)
    @value = data_hash.deep_symbolize_keys[:value]
  end

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['boolean']
    json
  end

  def mapping
    { name: mapping_field_name, type: :string, analyzer: :snowball }
  end

  def acceptable_validations?
    true
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_boolean"
  end
end
