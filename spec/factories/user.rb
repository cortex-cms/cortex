FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@careerbuilder.com" }
    sequence(:lastname) { |n| "user#{n}" }
    admin     false
    firstname 'test'
    password  'password'
    tenant

    initialize_with { new(password: password, password_confirmation: password) }
  end

  trait :admin do
    admin true
  end
end
