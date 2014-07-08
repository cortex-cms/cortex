FactoryGirl.define do
  factory :post do
    sequence(:title)  { |n| "post#{n}" }
    sequence(:slug)   { |n| "post-#{n}" }
    short_description 'This is a short description of the post that is long enough'
    copyright_owner   :'CareerBuilder, LLC'
    job_phase         :discovery
    display           :large
    type              :article
    author            :Author
    draft             true
    user

    trait :with_featured_media do
      association :featured_media, factory: [:media, :image]
    end
  end

  factory :promo do
    sequence(:title)  { |n| "post#{n}" }
    sequence(:slug)   { |n| "post-#{n}" }
    short_description 'This is a short description of the post that is long enough'
    copyright_owner   :'CareerBuilder, LLC'
    job_phase         :discovery
    display           :large
    type              :promo
    author            :Author
    draft             true
    destination_url   'Example.com'
    call_to_action    'Click me'
    user
  end
end
