FactoryGirl.define do
  factory :post do
    sequence(:title)  { |n| "post#{n}" }
    short_description 'Short description'
    job_phase         :discovery
    display           :large
    type              :article
    author            :Author
    draft             true
    user
  end
end
