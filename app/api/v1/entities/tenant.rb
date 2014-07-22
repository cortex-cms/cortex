module API::V1
  module Entities
    class Tenant < Grape::Entity
      expose :name, documentation: { type: "String", desc: "Tenant Name", required: true }
      expose :id, documentation: { type: "Integer", desc: "Tenant ID" }
      expose :contact_name, documentation: { type: "String", desc: "Contact Name" }
      expose :contact_email, documentation: { type: "String", desc: "Contact Email" }
      expose :contact_phone, documentation: { type: "String", desc: "Contact Phone" }
      expose :created_at, documentation: { type: 'dateTime', desc: "Creation Date"}
      expose :deleted_at, documentation: { type: 'dateTime', desc: "Deletion Date"}
      expose :deactive_at, documentation: { type: 'dateTime', desc: "Deactivation Date"}
      expose :active_at, documentation: { type: 'dateTime', desc: "Activation Date"}
      expose :updated_at, documentation: { type: 'dateTime', desc: "Update Date"}
      expose :contract, documentation: { type: "String", desc: "Contract" }
      expose :did, documentation: { type: "Integer", desc: "DID" }
      expose :parent_id, documentation: { type: "Integer", desc: "Parent ID" }
      expose :children, if: lambda { |instance, options| options[:children] }, documentation: { type: "Tenant", is_array: true, desc: "Child Tenants" }
    end
  end
end
