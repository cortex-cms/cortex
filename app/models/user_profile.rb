class UserProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  embeds_many :locations, class_name: 'UserLocation'

  field :user_id, type: Integer
  field :career_status, type: String

  # Could also use a custom mongoid field so this can be indexed and structure can be enforced
  field :custom_fields, type: Hash
end

class UserLocation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  embedded_in :user_profile

  field :postal_code, type: String
  field :country, type: String
end
