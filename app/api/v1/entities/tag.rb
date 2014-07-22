module API::V1
  module Entities
    class Tag < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "Tag ID" }
      expose :name, documentation: { type: "String", desc: "Tag Name" }
      expose :count, documentation: { type: "Integer", desc: "Tag Count" }
    end
  end
end
