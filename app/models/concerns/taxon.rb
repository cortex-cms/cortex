module Taxon
  extend ActiveSupport::Concern

  included do
    def taxon
      @taxon ||= create_taxon
    end

    def taxon=(taxon)
      @taxon = taxon
    end

    def self.taxon_class_name taxon_name=nil
      @taxon_class_name = taxon_name || @taxon_class_name || self.name
    end

    def self.taxon_class_name=(taxon_name)
      @taxon_class_name = taxon_name
    end

    private

    def create_taxon
      module_type = self.class.taxon_class_name.first.upcase
      taxon_date = created_at.strftime("%y%m%d")
      "#{module_type}#{taxon_type}#{taxon_date}#{taxon_created_at_index}"
    end

    def taxon_created_at_index
      # Returns count of assets created that day as hex
      '%04x' % self.class.with_deleted.where(created_at: Time.new(created_at.year, created_at.month, created_at.day)..created_at).count
    end
  end
end
