module Cortex
  class GenerateBulkUploadContentItemsCsvTransaction < Cortex::ApplicationTransaction
    include Cortex::BulkUploadable

    step :init
    step :process

    def init(input)
      content_type = ContentType.find_by_id(input[:content_type_id])

      if content_type
        Success(content_type)
      else
        Failure(:not_found)
      end
    end

    def process(content_type)
      headers = []
      content_type.field_items.each do |field_item|
        headers << field_item.field_type
      end
      Success(headers)
    end
  end
end
