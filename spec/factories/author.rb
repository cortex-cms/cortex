FactoryGirl.define do
  factory :author do
    firstname 'author'
    sequence(:lastname) { |n| "#{n}" }
  end
end
