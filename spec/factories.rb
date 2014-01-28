include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :asset do

    user

    trait :image do
      sequence(:name) { |n| "Sample Image#{n}" }
      description     'A very nice sample image'
      attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test.jpg'), 'image/jpeg') }

    end

    trait :document do
      sequence(:name) { |n| "Sample Document#{n}" }
      description     'A very nice sample document'
      attachment      { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test.pdf'), 'application/pdf') }
    end

    trait :movie do
      sequence(:name) { |n| "Sample Video#{n}" }
      description     'A very nice sample video'
      attachment      { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test.mp4'), 'video/mp4') }
    end

    factory :invalid_asset do
      name nil
    end

  end

  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}.email@gmail.com" }
    password 'awesomepassword'
    tenant

    initialize_with { new(password: password, password_confirmation: password) }
  end

  factory :tenant do
    name      'tenant'
    subdomain 'tenant'
    parent_id nil

    initialize_with { new(name: name, subdomain: subdomain) }

    factory :invalid_tenant do
      name nil
    end

    factory :organization do
      name      'organization'
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
