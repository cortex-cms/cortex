class BooleanFieldType < FieldType
  attr_accessor :data, :value, :field_name

  def data=(data_hash)
    @value = data_hash.deep_symbolize_keys[:value]
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['value']
    json
  end

  def mapping
    {name: mapping_field_name, type: :boolean}
  end

  private

  def mapping_field_name
    "#{field_name.downcase}_boolean"
  end
end
