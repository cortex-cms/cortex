module API
  module V1
    module Entities
      class Credential < Grape::Entity
        expose :id, documentation: { type: "Integer", desc: "Application ID", required: true }
        expose :name, documentation: { type: "String", desc: "Name", required: true }
        expose :redirect_uri, documentation: { type: "String", desc: "Redirect URI", required: true }
        expose :created_at, documentation: { type: 'dateTime', desc: "Created Date"}
        expose :updated_at, documentation: { type: 'dateTime', desc: "Last Updated Date"}
      end
    end
  end
end
