FactoryGirl.define do
  factory :user_profile do
    locations { [FactoryGirl.build(:location1), FactoryGirl.build(:location2)] }
    career_status 'Discovery'

    # Ugly! How can we make it better?
    user_id 1
  end

  factory :location1, :class => :user_location do
    postal_code '30011'
    country 'USA'
  end

  factory :location2, :class => :user_location do
    postal_code '10093'
    country 'UAE'
  end
end
