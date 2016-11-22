module Onet
  class Occupation < ApplicationRecord
    include SearchableOnetOccupation

    has_one :post

    # ONET represents its hierarchy in its SOC code - industries always have 0000 after the dash,
    # and the two-digit identifier before the dash represents the industry code itself.
    scope :industries, -> {
      where('soc like ?', '%0000%')
    }
  end
end
