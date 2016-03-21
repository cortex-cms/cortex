require 'rails_helper'

describe "Main Cortex Interface", :type => :feature, :js => true do

  context 'User is an Admin' do

    before(:each) do
      tenant = Tenant.create!({name: "test"})
      @admin = User.create!({:email => 'user@example.com', :password => 'password12345!', tenant_id: tenant.id, firstname: "Alias", lastname: "Testname", admin: true})

      visit '/#/login'
      fill_in 'user_email', :with => @admin.email
      fill_in 'user_password', :with => @admin.password
      click_button 'Sign In'
    end

    describe 'Tenants' do
      it 'should show Organizations as an option on the top bar' do
        expect(page).to have_content 'Tenants'
      end
    end

    describe 'Webpages' do
      it 'should show Webpages as an option on the top bar' do
        expect(page).to have_content 'Webpages'
      end
    end
  end

  context 'User is not an Admin' do

    before(:each) do
      tenant = Tenant.create!({name: "test"})
      @notadmin = User.create!({:email => 'user2@example.com', :password => 'password12345!', tenant_id: tenant.id, firstname: "Alias", lastname: "Testname", admin: false})

      visit '/#/login'
      fill_in 'user_email', :with => @notadmin.email
      fill_in 'user_password', :with => @notadmin.password
      click_button 'Sign In'
    end

    describe 'Tenants' do
      it 'should show not Organizations as an option on the top bar' do
        expect(page).to_not have_content 'Tenants'
      end

      it 'should redirect back to previous page if navigated to' do
        back_path_url = current_path
        visit '/#/organizations/'
        expect(current_path).to eq(back_path_url)
      end
    end

    describe 'Webpages' do
      it 'should show not Webpages as an option on the top bar' do
        expect(page).to_not have_content 'Webpages'
      end

      it 'should redirect back to previous page if navigated to' do
        back_path_url = current_path
        visit '/#/webpages/'
        expect(current_path).to eq(back_path_url)
      end
    end
  end

end
