FactoryGirl.define do
  factory :field_item do
    text { Faker::Lorem.paragraph }
    field
    content_item
  end
end
