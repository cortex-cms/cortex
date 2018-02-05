module Cortex
  class Tenant < Cortex::ApplicationRecord
    acts_as_nested_set

    has_many :content_items
    has_many :content_types
    has_many :contracts
    has_many :decorators
    has_and_belongs_to_many :users
    belongs_to :owner, class_name: 'User'
    has_many :users, foreign_key: :active_tenant_id, class_name: 'User'

    validates_presence_of :name
    validates_associated :owner

    validates_uniqueness_of :name,
                            :name_id

    alias_method :organization, :root

    def is_organization?
      root?
    end

    def has_children?
      !leaf?
    end

    def all_up_organization_for(klass)
      self_and_ancestors.flat_map do |tenant|
        tenant.public_send(klass.name.demodulize.underscore.pluralize).all
      end
    end

    def search_up_organization_for(klass, attribute, value)
      all_up_organization_for(klass).select do |record|
        record[attribute] == value
      end
    end
  end
end
