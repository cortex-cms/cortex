FactoryGirl.define do
  factory :media do
    user
    sequence(:name) { |n| "Media#{n}" }
    attachment { fixture_file_upload("#{Rails.root}/spec/support/media/test.txt", 'text/plain') }

    trait :document do
      attachment { fixture_file_upload("#{Rails.root}/spec/support/media/test.pdf", 'application/pdf') }
    end

    trait :movie do
      attachment { fixture_file_upload("#{Rails.root}/spec/support/media/test.mp4", 'video/mp4') }
    end

    trait :image do
      attachment { fixture_file_upload("#{Rails.root}/spec/support/media/test.jpg", 'image/jpeg') }
    end
  end
end
