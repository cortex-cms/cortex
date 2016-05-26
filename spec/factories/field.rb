FactoryGirl.define do
  factory :field do
    content_type
    field_type { "text_field_type" }
    required { false }
    name { Faker::Lorem.word }
    validations { {} }
  end
end
