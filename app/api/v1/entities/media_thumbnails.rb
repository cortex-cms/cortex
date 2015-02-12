module API
  module V1
    module Entities
      class MediaThumbnails < Grape::Entity
        expose :large, documentation: {desc: "Large thumbnail"} do |attachment| attachment.url(:large) end
        expose :medium, documentation: {desc: "Medium thumbnail"} do |attachment| attachment.url(:medium) end
        expose :default, documentation: {desc: "Default thumbnail"} do |attachment| attachment.url(:default) end
        expose :mini, documentation: {desc: "Mini thumbnail"} do |attachment| attachment.url(:mini) end
        expose :micro, documentation: {desc: "Micro thumbnail"} do |attachment| attachment.url(:micro) end
        expose :ar_post, documentation: {desc: "Media resized for A&R post page"} do |attachment| attachment.url(:ar_post) end
      end
    end
  end
end
