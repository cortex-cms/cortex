require 'rails_helper'

describe "Main Cortex Interface", :type => :feature, :js => true do
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:user)  { FactoryGirl.create :user  }

  context 'User is an Admin' do
    context 'When Logged in' do
      before(:each) do
        visit '/#/login'
        fill_in 'user_email', :with => admin.email
        fill_in 'user_password', :with => admin.password
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
  end

  context 'User is not an Admin' do
    context 'When Logged in' do
      before(:each) do
        visit '/#/login'
        fill_in 'user_email', :with => user.email
        fill_in 'user_password', :with => user.password
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

end
