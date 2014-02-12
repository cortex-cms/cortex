FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@careerbuilder.com" }
    password 'password'
    tenant

    initialize_with { new(password: password, password_confirmation: password) }
  end
end