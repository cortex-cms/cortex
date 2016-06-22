class FieldType < ActiveRecord::Base
  include ActiveSupport::DescendantsTracker

  def self.direct_descendant_names
    direct_descendants.map{ |descendant| descendant.name.underscore }
  end

  def self.get_subtype_constant(descendant_name)
    descendant_name.camelize.constantize
  end
end
