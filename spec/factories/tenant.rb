FactoryGirl.define do
  factory :tenant do
    sequence(:name) { |n| "tenant#{n}" }
    sequence(:subdomain) { |n| "tenant#{n}" }

    initialize_with { new(name: name, subdomain: subdomain) }
  end

  trait :second_tenant do
    id 300
  end
end
