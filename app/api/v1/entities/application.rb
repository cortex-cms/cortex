module API
  module V1
    module Entities
      class Application < Grape::Entity
        # expose :firstname, documentation: { type: "String", desc: "First Name" }
        expose :id, documentation: { type: "Integer", desc: "Application ID", required: true }
        expose :name, documentation: { type: "String", desc: "Name", required: true }
        expose :tenant, using: 'Entities::Tenant', documentation: { type: 'Tenant', is_array: false, desc: "Tenant", required: true}
        expose :created_at, documentation: { type: 'dateTime', desc: "Created Date"}
        expose :updated_at, documentation: { type: 'dateTime', desc: "Last Updated Date"}
      end
    end
  end
end
