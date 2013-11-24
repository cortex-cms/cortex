class Tenant < ActiveRecord::Base
    acts_as_nested_set
    belongs_to :organization
    #attr_protected :lft, :rgt, :depth
end
