module Taxon 
	extend ActiveSupport::Concern 

	def taxon
		main_type = self.class.name[0]

		taxon_date = created_at.strftime("%y%m%d")

		taxon_hex = SecureRandom.hex[0..2]

		"#{main_type}#{taxon_subtype}#{taxon_date}#{taxon_hex}"
	end

end