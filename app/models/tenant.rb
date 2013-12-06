class Tenant < ActiveRecord::Base
    acts_as_nested_set

    def database_name
      subdomain || name.normalize(:kd).downcase.gsub(/[^a-z0-9]/, '')
    end
end
