FactoryGirl.define do
  factory :category do
    sequence(:name)  { |n| "category#{n}" }
    user
  end
end