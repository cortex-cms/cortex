FactoryGirl.define do
  factory :field do
    content_type
    field_type { FieldType.direct_descendant_names.sample }
    required { false }
    name { Faker::Lorem.word }
  end
end
