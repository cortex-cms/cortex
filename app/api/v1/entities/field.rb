module V1
  module Entities
    class Field < Grape::Entity
      expose :id, documentation: { type: "UUID", desc: "ID of field" }
      expose :required, documentation: { type: "Boolean", desc: "Whether field is required" }
      # expose :validations, with: '::V1::Entities:Validation', documentation: { type: "Validations", desc: "Validations on field types"}
      expose :field_type, documentation: { type: "Integer", desc: "Associated field type" }
      expose :name, documentation: { type: "String", desc: "Name" }
    end
  end
end
