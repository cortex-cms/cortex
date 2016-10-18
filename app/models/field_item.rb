class FieldItem < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :field
  belongs_to :content_item

  validates :field_id, presence: true
  validates :content_item_id, presence: true, on: :update
  validate :field_item_content_is_valid, if: :field_is_present

  def data=(data_hash)
    @field_type_instance = nil
    super(field_type_instance(data_hash).data || data_hash)
  end

  private

  def field_type_instance(data_hash = nil)
    field_type_class = FieldType.get_subtype_constant(field.field_type)
    @field_type_instance ||= field_type_class.new(data: data_hash || data_before_type_cast, validations: field.validations)
    @field_type_instance if @field_type_instance.save!
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
