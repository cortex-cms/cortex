FactoryGirl.define do
  factory :author do
    sequence(:name) { |n| "author #{n}" }
  end
end
