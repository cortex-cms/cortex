require 'spec_helper'

RSpec.describe TextFieldType, type: :model do
  
  context "validation types" do
    it "has the acceptable validation types" do
      expect(TextFieldType::VALIDATION_TYPES).to be_present
    end

    it "includes length and presence" do
      expect(TextFieldType::VALIDATION_TYPES).to include(:length)
      expect(TextFieldType::VALIDATION_TYPES).to include(:presence)
    end
  end

  describe ".acceptable_validations" do
    it "returns true if the types of validations in the hash passed into it can be performed" do
      requested_validation = { length: 5 }
      expect(TextFieldType.acceptable_validations?(requested_validation)).to be true
    end

    it "returns false if any of the types of validations in the hash cannot be performed" do 
      requested_validation = { length: 5, bloop: "goop" }
      expect(TextFieldType.acceptable_validations?(requested_validation)).to be false
    end

    it "returns false if the options for a validation type are invalid" do
      requested_validation = { length: "string" }
      expect(TextFieldType.acceptable_validations?(requested_validation)).to be false
    end
  end

  context "validations" do 
    it "can validate presence" do
      text = ""
      validations = { presence: true}
      text_field_type = TextFieldType.new(text, validations)
      expect(text_field_type.valid?).to eq(false)
      expect(text_field_type.errors.full_messages).to match_array(["Text must be present"])
    end

    it "can validate maximum length" do
      text = "Hello!"
      validations = { length: 5 }
      text_field_type = TextFieldType.new(text, validations)
      expect(text_field_type.valid?).to eq(false)
      expect(text_field_type.errors.full_messages).to match_array(["Text must be no more than 5 characters"])
    end
  end
end