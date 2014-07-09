FactoryGirl.define do
  factory :post do
    sequence(:title)  { |n| "post#{n}" }
    sequence(:slug)   { |n| "post-#{n}" }
    short_description 'This is a short description of the post that is long enough'
    copyright_owner   :'CareerBuilder, LLC'
    job_phase         :discovery
    display           :large
    type              'ArticlePost'
    draft             true
    author
    user

    trait :with_featured_media do
      association :featured_media, factory: [:media, :image]
    end
  end

  factory :promo, class: 'PromoPost' do
    sequence(:title)  { |n| "post#{n}" }
    sequence(:slug)   { |n| "post-#{n}" }
    short_description 'This is a short description of the post that is long enough'
    copyright_owner   :'CareerBuilder, LLC'
    job_phase         :discovery
    display           :large
    type              'PromoPost'
    draft             true
    destination_url   'Example.com'
    call_to_action    'Click me'
    author
    user
  end
end
