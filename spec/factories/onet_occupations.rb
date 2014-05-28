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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :onet_occupation, :class => 'Onet::Occupation' do
    soc '11-1011.00'
    title 'Chief Executives'
    description 'Determine and formulate policies and provide overall direction of companies or private and public sector organizations within guidelines set up by a board of directors or similar governing body. Plan, direct, or coordinate operational activities at the highest level of management with the help of subordinate executives and staff managers.'
  end
end
