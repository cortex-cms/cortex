class FieldType < ActiveRecord::Base
  extend ActiveSupport::DescendantsTracker
  DEFAULT_MAPPINGS = [].freeze

  def self.direct_descendant_names
    direct_descendants.map{ |descendant| descendant.name.underscore }
  end

  def self.get_subtype_constant(descendant_name)
    descendant_name.camelize.constantize
  end

  def mappings
    DEFAULT_MAPPINGS + type_mappings
  end

  def type_mappings
    raise 'type_mappings must be implemented for a FieldType!'
  end
end
