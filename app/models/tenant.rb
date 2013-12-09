class Tenant < ActiveRecord::Base
    acts_as_nested_set
    belongs_to :user

    def database_name
      subdomain || name.normalize(:kd).downcase.gsub(/[^a-z0-9]/, '')
    end
end
