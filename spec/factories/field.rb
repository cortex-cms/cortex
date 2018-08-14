FactoryBot.define do
  factory :field do
    content_type
    field_type {"text_field_type"}
    required false
    name {Faker::Lorem.word}
    name_id {name.downcase}
    validations {{}}
    metadata {{}}

    trait :slug do
      validations {{length: {maximum: 75}, presence: true, uniqueness: true}}
    end
  end
end
