FactoryBot.define do
  factory :cortex_contract, class: 'Cortex::Contract' do
    name 'Bogus'
    association :tenant, factory: :cortex_tenant
  end
end
