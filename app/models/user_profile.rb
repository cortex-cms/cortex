class UserProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  embeds_many :locations, class_name: 'UserLocation'

  field :user_id, type: Integer
  field :career_status, type: String
end

class UserLocation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  embedded_in :user_profile

  field :postal_code, type: String
  field :country, type: String
end
