class TreeFieldType < FieldType
  attr_accessor :data, :tree, :field_name, :validations

  # def field_item_as_indexed_json_for_field_type(field_item, options = {})
  #   json = {}
  #   json[mapping_field_name] = field_name
  #   json
  # end

  def data=(data_hash)
    @tree = data_hash.deep_symbolize_keys[:tree]
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['tree'].to_json
    json
  end

  def mapping
    {name: mapping_field_name, type: :string, analyzer: :snowball}
  end

  def acceptable_validations?
    true
  end

  private

  def mapping_field_name
    "#{field_name.downcase}_tree"
  end
end
