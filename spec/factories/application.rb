FactoryGirl.define do
  factory :application do
    sequence(:name) { |n| "application#{n}" }
    tenant
  end
end
