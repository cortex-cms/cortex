# Preview all emails at http://localhost:3000/rails/mailers/password_reset_mailer
class PasswordResetMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/password_reset_mailer/send_password_reset
  def send_password_reset
    PasswordResetMailer.send_password_reset
  end

end
