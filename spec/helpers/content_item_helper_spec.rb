require 'spec_helper'
include ContentItemHelper

RSpec.describe ContentItemHelper, type: :helper do
  describe '#content_type' do
  end

  describe '#content_item' do
  end

  describe '#content_item_params' do
  end

  describe '#field_item_attributes_as_params' do
  end

  describe '#permit_attribute_params' do
    let(:params) { [{one: "1", two: "1"}, {one: "2", two: "2"}, {one: "3", two: "3"}] }
    let(:keys) { { one: [], two:[] } }

    it 'should return an Array' do
      expect(permit_attribute_params(params, keys)).to be_a_kind_of(Array)
    end

    it 'should match the expected format' do
      expect(permit_attribute_params(params, keys)).to eq([:one, :two])
    end

    context 'params contains a Hash' do
      let(:params) { [{one: { four: "1" }, two: "1"}, {one: "2", two: "2"}, {one: "3", two: "3"}] }

      it 'should match the expected format' do
        expect(permit_attribute_params(params, keys)).to eq([{:one=>[:four]}, :two])
      end
    end
  end

  describe '#permit_param' do
    context 'Nested Hash for parameters' do
      let (:param) { { one: { two: {} } } }
      let (:outcome) { permit_param(param) }

      it 'should return a Hash' do
        expect(outcome).to be_a_kind_of(Hash)
      end

      it 'should match the expected format' do
        expect(outcome).to eq({ param.keys[0].to_sym => param.values[0].keys })
      end
    end

    context 'Non Nested Hash for parameters' do
      let (:param) { { one: "two" } }
      let (:outcome) { permit_param(param) }

      it 'should return an Array' do
        expect(outcome).to be_a_kind_of(Array)
      end

      it 'should contain Symbols' do
        expect(outcome.sample).to be_a_kind_of(Symbol)
      end

      it 'should match the given param' do
        expect(outcome).to eq(param.keys)
      end
    end
  end

  describe '#sanitize_parameters' do
    context 'Has a Value' do
      let (:param) { { :one => ["two", "three", "two"] } }
      let (:outcome) { sanitize_parameters(param) }

      it 'should return a Hash in the Array' do
        expect(outcome.sample).to be_a_kind_of(Hash)
      end

      it 'should have the key of the given param' do
        key = param.keys[0]
        expect(outcome.sample.keys).to include(key)
      end

      it 'should have unique values' do
        key = param.keys[0]
        expect(outcome.sample[key]).to eq(param[key].uniq)
      end

      it 'should match the expected value' do
        key = param.keys[0]
        expect(outcome).to eq([{ key => param[key].uniq }])
      end
    end

    context 'Does not have a Value' do
      let (:param) { { :one => "" } }
      let (:outcome) { sanitize_parameters(param) }

      it 'should have the key of the given param' do
        key = param.keys[0]
        expect(outcome).to include(key)
      end

      it 'should match the expected format' do
        key = param.keys[0]
        expect(outcome).to eq([key])
      end
    end

    it 'should return an Array' do
      expect(sanitize_parameters({})).to be_a_kind_of(Array)
    end
  end
end
