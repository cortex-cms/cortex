FactoryGirl.define do
  factory :field do
    content_type
    field_type { Faker::Commerce.department }
    required { false }
  end
end