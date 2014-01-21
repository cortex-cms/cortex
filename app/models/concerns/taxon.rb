module Taxon
	extend ActiveSupport::Concern

  def taxon
    @taxon ||= create_taxon
  end

  def taxon=(taxon)
    @taxon = taxon
  end

  private

	def create_taxon
	  module_type = self.class.name.first
		taxon_date = created_at.strftime("%y%m%d")
		"#{module_type}#{taxon_type}#{taxon_date}#{taxon_created_at_index}"
  end

  def taxon_created_at_index
    # Returns count of assets created that day as hex
    '%04x' % self.class.with_deleted.where(created_at: Time.new(created_at.year, created_at.month, created_at.day)..created_at).count
  end

end
