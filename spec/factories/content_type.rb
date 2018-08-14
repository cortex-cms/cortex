FactoryBot.define do
  factory :content_type do
    name {Faker::Commerce.product_name}
    contract
    description {Faker::Lorem.sentence(4, false, 0)}
    association :creator, factory: :user
  end
end
