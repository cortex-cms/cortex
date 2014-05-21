# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :onet_occupation, :class => 'Onet::Occupation' do
    soc "MyString"
    title "MyString"
    description "MyText"
  end
end
