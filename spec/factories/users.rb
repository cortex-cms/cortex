FactoryBot.define do
  factory :cortex_user, class: 'Cortex::User' do
    firstname {Faker::Name.first_name}
    lastname {Faker::Name.last_name}
    email {Faker::Internet.unique.safe_email}
    password {Faker::Internet.password}

    transient do
      tenants_count 5
    end

    after(:create) do |user, evaluator|
      create_list(:cortex_tenant, evaluator.tenants_count, users: [user], owner: user)
    end
  end
end
