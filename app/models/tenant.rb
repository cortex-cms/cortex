class Tenant < ActiveRecord::Base
    acts_as_nested_set
    belongs_to :user
    after_initialize :init

    def is_organization?
      parent_id == nil
    end

    def init
      self.subdomain ||= name.mb_chars.normalize(:kd).downcase.gsub(/[^a-z0-9]/, '').to_s
    end
end
