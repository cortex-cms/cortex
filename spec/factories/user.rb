FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@cortexcms.org" }
    sequence(:lastname) { |n| "user#{n}" }
    firstname 'test'
    admin     false
    password  'password'
    tenant

    initialize_with { new(password: password, password_confirmation: password) }
  end

  trait :admin do
    admin true
  end
end
