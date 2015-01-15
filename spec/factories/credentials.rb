FactoryGirl.define do
  factory :credentials, class: Doorkeeper::Application do
    sequence(:name) { |n| "credentials#{n}" }
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
    association :owner, factory: :application
  end
end
