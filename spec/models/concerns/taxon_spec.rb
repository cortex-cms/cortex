require 'spec_helper'

describe Taxon do

  before do
    Timecop.freeze(Time.local(2014, 1, 1, 10, 5, 0))
  end

  context 'asset model' do

    it 'returns built taxon when provided an Asset of type Document' do
      media = create(:media, :document)
      doc_taxon = media.taxon
      expect(doc_taxon).to eq('MDOC1401010001')
    end

    it 'returns built taxon when provided an Asset of type Movie' do
      media = create(:media, :movie)
      vid_taxon = media.taxon
      expect(vid_taxon).to eq('MVID1401010001')
    end

    it 'returns built taxons with correct hex counts when provided 2 Assets' do
      media1 = create(:media, :document)
      doc_taxon1 = media1.taxon
      expect(doc_taxon1).to eq('MDOC1401010001')

      media2 = create(:media, :document)
      doc_taxon2 = media2.taxon
      expect(doc_taxon2).to eq('MDOC1401010002')
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