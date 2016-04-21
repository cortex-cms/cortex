require 'rails_helper'

describe "User Authentication", :type => :feature, js: true, pending: 'All Feature specs are broken on Travis' do
  describe 'Signing In' do
    let(:user) { FactoryGirl.create :user }

    it "Signs the User In" do
      visit '/#/login'
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      click_button 'Sign In'
      expect(page).to have_content 'Home'
    end
  end
end
