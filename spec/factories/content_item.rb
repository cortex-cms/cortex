FactoryGirl.define do
  factory :content_item do
    state { ["draft", "published"].sample }
    association :creator, factory: :user
    content_type
  end
end
