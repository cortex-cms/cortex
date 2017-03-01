class FieldItem < ApplicationRecord
  acts_as_paranoid
  belongs_to :field
  belongs_to :content_item

  validates :field_id, presence: true
  validates :content_item_id, presence: true, on: :update
  validate :field_item_content_is_valid, if: :field_is_present

  def data=(data_hash)
    # Reset @field_type_instance so that massaged data can be re-generated every time @data is set, not just on init
    @field_type_instance = nil
    super(field_type_instance(data_hash).data || data_hash)
  end

  private

  def field_type_instance_params(data_hash)
    # Carefully construct a params object so we don't trigger our fragile setters when a value is nil
    params = {metadata: field.metadata.merge({existing_data: data}), field: field, validations: field.validations}
    params[:data] = data_hash if data_hash
    params
  end

  def field_type_instance(data_hash = nil)
    field_type_class = FieldType.get_subtype_constant(field.field_type)
    # data_before_typecast will give us a non-mutilated hash with Objects intact, just in case validations get called first
    @field_type_instance ||= field_type_class.new(field_type_instance_params(data_hash))
    @field_type_instance.save
    @field_type_instance
  end

  def field_is_present
    field.present?
  end

  def field_item_content_is_valid
    add_specific_errors unless field_item_validates
  end

  def field_item_validates
    field_type_instance.valid?
  end

  def add_specific_errors
    field_type_instance.errors.each do |k, v|
      errors.add(field.name.to_sym, v)
    end
  end
end
