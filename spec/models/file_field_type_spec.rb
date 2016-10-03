# require 'spec_helper'
#
# RSpec.xdescribe FileFieldType, type: :model do
#   context "validation types" do
#     it "has the acceptable validation types" do
#       expect(FileFieldType::VALIDATION_TYPES).to be_present
#     end
#
#     it "includes length and presence" do
#       expect(FileFieldType::VALIDATION_TYPES).to include(:size)
#       expect(FileFieldType::VALIDATION_TYPES).to include(:presence)
#       expect(FileFieldType::VALIDATION_TYPES).to include(:content_type)
#     end
#   end
#
#   describe "#initialize" do
#     let(:asset) { File.new(Rails.root.join("spec", "fixtures", "test_image_179kb.jpg")) }
#     let(:subject) do
#       FileFieldType.new(
#         "data" => { "document"=> file },
#         "validations"=> {
#           "presence"=> true,
#           "size"=> { "less_than"=> 1.megabyte }
#         }
#       )
#     end
#
#     it "saves the file passed into it" do
#       expect(subject.document_file_name).to eq("test_image_179kb.jpg")
#     end
#
#     it "symbolizes and saves the validations hash passed into it" do
#       expect(subject.validations).to eq({ presence: true, size: { less_than: 1.megabyte } })
#     end
#   end
#
#   describe "#acceptable_validations?" do
#     let(:subject) { FileFieldType.new }
#
#     context "presence validation" do
#       it "returns true when there is any value for presence" do
#         subject.validations = { "presence"=> true }
#         expect(subject.acceptable_validations?).to be true
#
#         subject.validations = { "presence"=> false }
#         expect(subject.acceptable_validations?).to be true
#
#         subject.validations = { "presence"=> "whatever"}
#         expect(subject.acceptable_validations?).to be true
#       end
#     end
#
#     context "size validation" do
#       context "with valid options" do
#         it "returns true" do
#           subject.validations = { "size"=> { "greater_than"=> 0.5.megabytes, "less_than"=> 1.megabyte } }
#           expect(subject.acceptable_validations?).to be true
#         end
#       end
#
#       context "with invalid options" do
#         it "returns false" do
#           subject.validations = { "size"=> { "grander_than"=> 1.megabyte } }
#           expect(subject.acceptable_validations?).to be false
#         end
#       end
#     end
#
#     context "content type validation" do
#       context "with valid options" do
#         it "returns true" do
#           subject.validations = { "content_type"=> { "content_type"=> ["image/jpeg", "image/gif"] } }
#           expect(subject.acceptable_validations?).to be true
#         end
#       end
#
#       context "with invalid options" do
#         it "returns false" do
#           subject.validations = { "content_type"=> { "Gellman"=> ["image/jpeg", "image/gif"] } }
#           expect(subject.acceptable_validations?).to be false
#         end
#       end
#     end
#   end
# end
