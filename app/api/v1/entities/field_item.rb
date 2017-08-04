module V1
  module Entities
    class FieldItem < Grape::Entity
      expose :id, documentation: { type: "UUID", desc: "ID of field item" }
      expose :data, documentation: { type: "Hash", desc: "Field item data"}
      expose :field_name, documentation: { type: "String", desc: "Name of associated field" } do |field_item|
        field_item.field.name
      end
    end
  end
end
