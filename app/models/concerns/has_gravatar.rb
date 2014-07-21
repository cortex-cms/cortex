require 'digest/md5'

module HasGravatar
  extend ActiveSupport::Concern

  included do
    def avatars
      hash = email ? Digest::MD5.hexdigest(email) : '00000000000000000000000000000000'
      url  = "//www.gravatar.com/avatar/#{hash}"
      {
        default: "#{url}",
        small:   "#{url}?s=200",
        medium:  "#{url}?s=400",
        large:   "#{url}?s=1000"
      }
    end
  end
end