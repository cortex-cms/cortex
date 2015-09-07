require 'rails_helper'

RSpec.feature "ResetPasswords", type: :feature, js: true do
  it 'should show a success message with a valid email' do
    visit '/'
    click_link 'Reset Password'
    fill_in 'Email', with: 'test@example.com'
    page.find(".btn").click
    expect(page).to have_content 'successfully'
  end

  it 'should show an error message with an invalid message' do

  end
end
