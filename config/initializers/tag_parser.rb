module Cortex
  def self.available_tag_parsers
    @available_tag_parsers ||= [:media]
  end
end
