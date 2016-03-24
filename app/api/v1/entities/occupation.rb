module V1
  module Entities
    class Occupation < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "Occupation ID" }
      expose :soc, documentation: { type: "String", desc: "SOC code" }
      expose :title, documentation: { type: "String", desc: "Occupation Title" }
      expose :description, documentation: { type: "String", desc: "Occupation Description" }
    end
  end
end
