FactoryBot.define do
  factory :cortex_decorator, class: 'Cortex::Decorator' do
    name 'Wizard'
    data {}
    association :tenant, factory: :cortex_tenant
  end
end
