FactoryGirl.define do
  factory :document do
    user
    sequence(:name) { |n| "Document#{n}" }
    body 'I am to cool for my socks'
  end
end
