class FieldType
  include ActiveModel::Validations
  include ActiveSupport::DescendantsTracker

  def self.direct_descendant_names
    direct_descendants.map{ |descendant| descendant.name.underscore }
  end
end
