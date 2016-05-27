FactoryGirl.define do
  factory :content_item do
    publish_state { ["draft", "published"].sample }
    association :creator, factory: :user
    association :author, factory: :user
    published_at DateTime.now
    content_type
  end
end
