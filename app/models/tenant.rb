class Tenant < ActiveRecord::Base
    acts_as_nested_set
    attr_protected :lft, :rgt, :depth
end
