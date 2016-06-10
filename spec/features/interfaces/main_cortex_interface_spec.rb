require 'rails_helper'

describe "Main Cortex Interface", :type => :feature, js: true do
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:user)  { FactoryGirl.create :user  }

  context 'User is an Admin' do
    context 'When Logged in' do
      before(:each) do
        visit '/'
        within('#legacy-panel') do
          fill_in 'Email', :with => admin.email
          fill_in 'Password', :with => admin.password
          click_button 'Log in'
        end
      end

      describe 'Tenants' do
        xit 'should show Organizations as an option on the top bar' do
          expect(page).to have_content 'Tenants'
        end
      end

      describe 'Webpages' do
        xit 'should show Webpages as an option on the top bar' do
          expect(page).to have_content 'Webpages'
        end
      end
    end
  end

  context 'User is not an Admin' do
    context 'When Logged in' do
      before(:each) do
        visit '/'
        within('#legacy-panel') do
          fill_in 'Email', :with => user.email
          fill_in 'Password', :with => user.password
          click_button 'Log in'
        end
      end

      describe 'Tenants' do
        it 'should show not Organizations as an option on the top bar' do
          expect(page).to_not have_content 'Tenants'
        end

        it 'should redirect back to previous page if navigated to' do
          back_path_url = current_path + '/'
          visit '/legacy/#/organizations/'
          expect(current_path).to eq(back_path_url)
        end
      end

      describe 'Webpages' do
        it 'should show not Webpages as an option on the top bar' do
          expect(page).to_not have_content 'Webpages'
        end

        it 'should redirect back to previous page if navigated to' do
          back_path_url = current_path + '/'
          visit '/legacy/#/webpages/'
          expect(current_path).to eq(back_path_url)
        end
      end
    end
  end

end
