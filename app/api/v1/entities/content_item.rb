module V1
  module Entities
    class ContentItem < Grape::Entity
      expose :id, documentation: {type: "Integer", desc: "Content Item ID", required: true}
      expose :publish_state, documentation: {type: "String", desc: "Publish state", required: true}
    end
  end
end
