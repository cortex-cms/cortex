class BooleanFieldType < FieldType
  attr_accessor :data, :value, :field_name
  attr_reader :metadata

  validate :value_is_allowed?

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
    { name: mapping_field_name, type: :boolean }
  end

  private

  def mapping_field_name
    "#{field_name.downcase.parameterize('_')}_boolean"
  end

  def value_is_allowed?
    if [true, false].include?(value)
      true
    else
      errors.add(:value, "must be True or False")
      false
    end
  end
end
