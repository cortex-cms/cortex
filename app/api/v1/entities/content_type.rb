module V1
  module Entities
    class ContentType < Grape::Entity
      expose :id, documentation: { type: "UUID", desc: "Content Type ID" }
      expose :name, documentation: { type: "String", desc: "Content Type name" }

      with_options if: { fields: true } do
        expose :fields, using: '::V1::Entities::Field', documentation: { type: "Fields", is_array: true, desc: "Associated fields" }
      end
    end
  end
end
