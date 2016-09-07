class FieldItem < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :field
  belongs_to :content_item

  # after_validation :serialize_tree_values
  #
  # def serialize_tree_values
  #   if field.field_type == "tree_field_type"
  #     values = self.data["values"]
  #     self.data = { values: values.select { |kv| values[kv] == "1" }.keys.map { |k| k.to_s } }
  #   end
  # end

  validates :field_id, presence: true
  validates :content_item_id, presence: true, on: :update
  validate :field_item_content_is_valid, if: :field_is_present

  private

  def field_is_present
    field.present?
  end

  def field_item_content_is_valid
    add_specific_errors unless field_item_validates
  end

  def field_item_validates
    field_type_class = FieldType.get_subtype_constant(field.field_type)
    @field_type_instance = field_type_class.new(data: data, validations: field.validations)
    @field_type_instance.valid?
  end

  def add_specific_errors
    @field_type_instance.errors.each do |k, v|
      errors.add(field.name.to_sym, v)
    end
  end
end
