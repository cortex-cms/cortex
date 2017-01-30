class FieldType < ApplicationRecord
  extend ActiveSupport::DescendantsTracker
  DEFAULT_MAPPINGS = [].freeze
  #include ApplicationHelper
  attr_accessor :field_name, :field
  attr_reader :data, :validations, :metadata

  def self.direct_descendant_names
    direct_descendants.map{ |descendant| descendant.name.underscore }
  end

  def self.get_subtype_constant(descendant_name)
    descendant_name.camelize.constantize
  end

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys if validations_hash
  end

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys if metadata_hash
  end

  def mappings
    DEFAULT_MAPPINGS + type_mappings
  end

  def type_mappings
    raise 'type_mappings must be implemented for a FieldType!'
  end

  # def flash_error(mess)
  #   binding.pry
  #   flash[:warning] = mess
  # end

  def acceptable_validations?
    valid_types? && valid_options?
  end

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
end
