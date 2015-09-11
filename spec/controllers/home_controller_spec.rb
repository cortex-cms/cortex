require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'POST login/reset_password' do

    let(:user) { create(:user) }

    it 'should return 404 when the email is not on file' do
      post 'submit_password_reset', user: { email: 'invalid_email@example.com' }
      expect(flash[:error]).to be_present
    end

    context 'when the email is on file' do
      it 'should reutrn 201 when the email is on file' do
        post 'submit_password_reset', user: { email: user.email }
        expect(flash[:success]).to be_present
      end

      it 'should generate a reset token' do
        expect{
          post 'submit_password_reset', user: { email: user.email }
          user.reload
        }.to change{ user.encrypted_password }
      end

      context 'the password email' do
        it 'should be sent' do
          post 'submit_password_reset', user: { email: user.email }
          expect(ActionMailer::Base.deliveries).not_to be_empty
        end
      end
    end

  end
end
