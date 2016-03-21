require 'rails_helper'

describe "User Authentication", :type => :feature, :js => true do
  describe 'Signing In' do
    before :each do
      tenant = Tenant.create!({name: "test"})
      @user = User.create!({:email => 'user@example.com', :password => 'password12345!', tenant_id: tenant.id, firstname: "Alias", lastname: "Testname", admin: false})
    end

    it "Signs the User In" do
      visit '/#/login'
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
      click_button 'Sign In'
      expect(page).to have_content 'Home'
    end
  end
end
