FactoryGirl.define do

  factory :user do
    name 'user'
    email 'user@email.com'
    password 'awesomepassword'

    initialize_with { new(password: password, password_confirmation: password) }
  end

  factory :tenant do
    name 'tenant'
    subdomain 'tenant'
    parent_id nil
    user

    initialize_with { new(name: name, subdomain: subdomain) }

    factory :organization do
      name 'tenant'
      subdomain 'organization'

      after(:create) do |o|
        tenant = create(:tenant, name: 'tenant', user: o.user)
        tenant.move_to_child_of(o)

        subtenant = create(:tenant, name: 'subtenant', user: o.user)
        subtenant.move_to_child_of(tenant)
      end
    end
  end
end
