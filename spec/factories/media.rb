# == Schema Information
#
# Table name: media
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  user_id                 :integer
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  dimensions              :string(255)
#  description             :text
#  alt                     :string(255)
#  active                  :boolean
#  deactive_at             :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  digest                  :string(255)      not null
#  deleted_at              :datetime
#

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
