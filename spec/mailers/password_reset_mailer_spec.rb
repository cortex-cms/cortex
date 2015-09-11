require "rails_helper"

RSpec.describe PasswordResetMailer, type: :mailer do
  describe "send_password_reset" do
    let(:mail) { PasswordResetMailer.send_password_reset({ email: "test@example.com", password: "1234" }) }

    it 'sends to the email address of the user' do
      expect(mail).to deliver_to "test@example.com"
    end

    it 'includes the new password in the email' do
      expect(mail).to have_body_text "1234"
    end

    it 'has a meaningful subject' do
      expect(mail).to have_subject "CB Cortex Password Reset"
    end
  end

end
