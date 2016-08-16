class TreeFieldType < FieldType
  VALIDATION_TYPES = {
    length: :no_more_than_two
  }.freeze

  attr_accessor :data, :tree, :field_name, :validations
  attr_reader :validations

  validate :no_more_than_two

  def data=(data_hash)
    if data_hash.nil?
      @data = {"tree"=>[]}
      @tree = []
    else
      @tree = data_hash.deep_symbolize_keys[:tree]
    end
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    field_item.data ||= {"tree" =>[]}
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

  def no_more_than_two
    if tree.count > 2
      errors.add(:expiration_date, "can't have more than two")
    end
  end
end
