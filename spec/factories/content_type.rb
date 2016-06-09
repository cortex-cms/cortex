FactoryGirl.define do
  factory :content_type do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    association :creator, factory: :user 
  end
end