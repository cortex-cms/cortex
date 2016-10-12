FactoryGirl.define do
  factory :bulk_job do
    content_type "Test"
    metadata_file_name "File name"
    metadata_updated_at DateTime.now
  end
end
