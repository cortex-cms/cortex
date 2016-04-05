require 'rails_helper'

describe 'Tenants', :type => :feature, :js => true do
  let(:admin)  { FactoryGirl.create :user, :admin }
  let(:tenant) { FactoryGirl.create :tenant }

  context 'When Logged in' do
    before(:each) do
      visit '/#/login'
      fill_in 'user_email', :with => admin.email
      fill_in 'user_password', :with => admin.password
      click_button 'Sign In'

      visit '/#/organizations/'
    end

    describe 'Index' do
      it 'should display the names of all Tenants in buttons' do
        expect(page).to have_css('button', text: tenant.name)
      end
    end

    describe 'Create Tenant Button' do
      it 'should have a button to create a Tenant' do
        expect(page).to have_css('button', text: 'Create Organization')
      end

      xit 'should link to the new tenant form' do
        page.find(".org-btn").click
        expect(current_path).to eq('/#/organizations//tenants/new')
      end
    end

    describe 'New Tenant' do
      before(:each) do
        visit '/#/organizations//tenants/new'
      end

      it 'should have instructions' do
        expect(page).to have_text('INSTRUCTIONS')
      end

      describe 'Form' do
        describe 'Name' do
          it 'should be present' do
          end

          it 'should say Name in placeholder text' do
          end

          it 'should be marked as "Required"' do
          end
        end

        describe 'Contact Name' do
          it 'should be present' do
          end

          it 'should say Contact Name in placeholder text' do
          end
        end

        describe 'Contact Email' do
          it 'should be present' do
          end

          it 'should say Contact Email in placeholder text' do
          end
        end

        describe 'Contact Phone' do
          it 'should be present' do
          end

          it 'should say Contact Phone in placeholder text' do
          end
        end

        describe 'Activate Date' do
          it 'should be present' do
          end

          it 'should say Activate Date in placeholder text' do
          end
        end

        describe 'Deactivate Date' do
          it 'should be present' do
          end

          it 'should say Deactivate Date in placeholder text' do
          end
        end

        describe 'Contract Number' do
          it 'should be present' do
          end

          it 'should say Contract Number in placeholder text' do
          end
        end

        describe 'DID' do
          it 'should be present' do
          end

          it 'should say DID in placeholder text' do
          end
        end

        describe 'Submit Button' do
          it 'should say "Create"' do
          end

          context 'Required Fields NOT Entered' do
            it 'should be disabled' do
            end
          end

          context 'Required Fields Entered' do
            it 'should not be disabled' do
            end

            it 'should submit the form' do
            end

            it 'should redirect to Index' do
            end
          end
        end
      end
    end

    describe 'Show Tenant' do
    end

  end
end
