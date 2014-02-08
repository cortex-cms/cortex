module API::V1
  module Entities
    class MediaThumbnails < Grape::Entity
      expose(:large)   { |attachment| attachment.url(:large) }
      expose(:default) { |attachment| attachment.url(:default) }
      expose(:mini)    { |attachment| attachment.url(:mini) }
      expose(:micro)   { |attachment| attachment.url(:micro) }
    end
  end
end
