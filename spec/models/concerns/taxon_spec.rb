require 'spec_helper'

describe Taxon do

  context 'asset model' do

    it 'returns built taxon when provided an Asset of type Document' do
      asset = create(:asset)
      asset.taxon
      expect(taxon).to eq(ADOC1401210001)
    end

    it 'returns built taxon when provided an Asset of type Movie' do
      asset = create(:asset)

    end

    it 'returns built taxons with correct hex counts when provided 2 Assets' do
      asset = create(:asset)

    end

  end

=begin
  it 'returns built taxon when provided a Package' do
    asset = build(:asset)
  end
=end

=begin
  it 'returns built taxons with correct hex counts when provided 2 Assets and 3 Packages' do
    asset = build(:asset)
  end
=end

end