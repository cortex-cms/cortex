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

require 'spec_helper'

describe Onet::Occupation do
  pending "add some examples to (or delete) #{__FILE__}"
end
