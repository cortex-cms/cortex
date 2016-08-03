require 'spec_helper'

RSpec.describe TreeFieldType, type: :model do
  context "validation types" do
    it "has the acceptable validation types" do
      expect(TreeFieldType::VALIDATION_TYPES).to be_present
    end

    it "includes length and presence" do
      expect(TreeFieldType::VALIDATION_TYPES).to include(:presence)
    end
  end

  describe "#initialize" do
    let(:subject) { TreeFieldType.new("data" => { "values" => [1,2,3] }, "validations"=> { presence: true }, "metadata" => { "Bloop" => true } ) }

    it "saves the text from the data hash passed into it" do
      expect(subject.values).to eq([1,2,3])
    end

    it "symbolizes and saves the validations hash passed into it" do
      expect(subject.validations).to eq({ presence: true })
    end

    it "saves the metadata from the metadata hash passed into it" do
      expect(subject.metadata).to eq({Bloop: true})
    end
  end

  describe "#acceptable_validations?" do
    let(:subject) { TreeFieldType.new }

    it "returns true if the types of validations in the hash passed into it can be performed" do
      subject.validations = { "presence" => true }
      expect(subject.acceptable_validations?).to be true
    end

    it "returns false if any of the types of validations in the hash cannot be performed" do
      subject.validations = { "presence"=> true, "bloop"=> "goop" }
      expect(subject.acceptable_validations?).to be false
    end
  end

  describe '#value_is_allowed?' do
    context 'Value is allowed in metadata' do
      let(:subject) { TreeFieldType.new("data" => { "values" => [1,2,3] }, "validations"=> { presence: true }, "metadata" => {
         :allowed_values => [
           { :name => "Art", :id => 1, :children => [] },
           { :name => "Computers", :id => 2, :children => [] },
           { :name => "Management", :id => 3, :children => [] },
           { :name => "Action", :id => 4, :children => [] } ]
      } ) }

      it 'should be valid' do
        expect(subject.valid?).to be_truthy
      end
    end

    context 'Value is NOT allowed in metadata' do
      let(:subject) { TreeFieldType.new("data" => { "values" => [1,2,3,42] }, "validations"=> { presence: true }, "metadata" => {
         :allowed_values => [
           { :name => "Art", :id => 1, :children => [] },
           { :name => "Computers", :id => 2, :children => [] },
           { :name => "Management", :id => 3, :children => [] },
           { :name => "Action", :id => 4, :children => [] } ]
      } ) }

      it 'should throw a custom error' do
        subject.save
        expect(subject.errors.full_messages).to include("Value must be allowed.")
      end
    end

  end
end
