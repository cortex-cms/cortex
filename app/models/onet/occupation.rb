# == Schema Information
#
# Table name: onet_occupations
#
#  id          :integer          not null, primary key
#  soc         :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

module Onet
  class Occupation < ActiveRecord::Base
    include SearchableOnetOccupation

    has_one :post

    # ONET represents its hierarchy in its SOC code - industries always have 0000 after the dash,
    # and the two-digit identifier before the dash represents the industry code itself.
    scope :industries, -> {
      where('soc like ?', '%0000%')
    }
  end
end

