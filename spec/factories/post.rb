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

    trait :with_featured_image do
      association :featured_media, factory: :media
    end
  end
end
