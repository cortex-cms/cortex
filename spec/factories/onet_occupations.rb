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
    soc "MyString"
    title "MyString"
    description "MyText"
  end
end
