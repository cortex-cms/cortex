class Tenant < ActiveRecord::Base
    acts_as_nested_set
    after_initialize :init

    belongs_to :user
    has_and_belongs_to_many :posts

    def is_organization?
      parent_id == nil
    end

    def init
      self.subdomain ||= name.mb_chars.normalize(:kd).downcase.gsub(/[^a-z0-9]/, '').to_s
    end
end
