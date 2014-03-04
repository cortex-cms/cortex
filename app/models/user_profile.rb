class UserProfile
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :locations, class_name: :UserLocation

  field :user_id, type: Integer
end

class UserLocation
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user_profile

  field :postal_code, type: String
  field :country, type: String
end
