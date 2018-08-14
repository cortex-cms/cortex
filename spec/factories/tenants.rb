FactoryBot.define do
  factory :cortex_tenant, class: 'Cortex::Tenant' do
    sequence(:name) {|n| "tenant #{n}"}
    sequence(:name_id) {|n| "tenant_#{n}"}
    description {Faker::Lorem.sentence(4, false, 0)}
  end
end
