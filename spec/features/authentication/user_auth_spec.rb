require 'rails_helper'

xdescribe "User Authentication", :type => :feature, js: true do
  describe 'Signing In' do
    let(:user) { FactoryGirl.create :user }

    it "Signs the User In" do
      visit '/users/sign_in'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign In'
      expect(page).to have_content 'Home'
    end
  end
end
