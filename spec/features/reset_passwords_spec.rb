require 'rails_helper'

RSpec.feature "ResetPasswords", type: :feature do
  it 'should show a success message with a valid email' do
    visit '/login'
    click 'Reset Password'
    fill_in 'Email', with: 'test@example.com'
    click_button 'Send Password Reset'
    expect(page).to have_content 'successfully'
  end

  it 'should show an error message with an invalid message' do

  end
end
