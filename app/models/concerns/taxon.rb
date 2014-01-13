module Taxon 
	extend ActiveSupport::Concern

	def taxon
		main_type = self.class.name[0]

		taxon_date = created_at.strftime("%y%m%d")

		"#{main_type}#{taxon_subtype}#{taxon_date}#{taxon_created_at_index}"
  end

  def taxon_created_at_index
    '%04x' % self.class.with_deleted.where(created_at: Time.new(created_at.year, created_at.month, created_at.day)..created_at).count
  end

end