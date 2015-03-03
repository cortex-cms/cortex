FactoryGirl.define do
  factory :post, class: ArticlePost do
    sequence(:title)    { |n| "post#{n}" }
    sequence(:slug)     { |n| "post-#{n}" }
    short_description   'This is a short description of the post that is long enough'
    body                '<p style="sanitize-test-class">Test paragraph text</p><script type="javascript">alert("I should still remain");</script>'
    copyright_owner     :'CareerBuilder, LLC'
    job_phase           :Discovery
    display             :large
    type                'ArticlePost'
    draft               false
    published_at        DateTime.now
    industries          []
    primary_industry_id 1
    categories          []
    primary_category_id 1
    author
    user

    trait :with_featured_media do
      association :featured_media, factory: [:media, :image]
    end
  end

  factory :promo, class: 'PromoPost' do
    sequence(:title)    { |n| "post#{n}" }
    sequence(:slug)     { |n| "post-#{n}" }
    short_description   'This is a short description of the post that is long enough'
    copyright_owner     :'CareerBuilder, LLC'
    job_phase           :Discovery
    display             :large
    type                'PromoPost'
    draft               false
    published_at        DateTime.now
    industries          []
    primary_industry_id 1
    categories          []
    primary_category_id 1
    destination_url     'Example.com'
    call_to_action      'Click me'
    author
    user
  end
end
