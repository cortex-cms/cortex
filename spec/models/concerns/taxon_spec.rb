require 'spec_helper'

describe Taxon do

  before do
    Timecop.freeze(Time.local(2014, 1, 1, 10, 5, 0))
  end

  context 'asset model' do

    it 'returns built taxon when provided an Asset of type Document' do
      asset = create(:asset, :document)
      doc_taxon = asset.taxon
      expect(doc_taxon).to eq('ADOC1401010001')
    end

    it 'returns built taxon when provided an Asset of type Movie' do
      asset = create(:asset, :movie)
      vid_taxon = asset.taxon
      expect(vid_taxon).to eq('AVID1401010001')
    end

    it 'returns built taxons with correct hex counts when provided 2 Assets' do
      asset1 = create(:asset, :document)
      doc_taxon1 = asset1.taxon
      expect(doc_taxon1).to eq('ADOC1401010001')

      asset2 = create(:asset, :document)
      doc_taxon2 = asset2.taxon
      expect(doc_taxon2).to eq('ADOC1401010002')
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