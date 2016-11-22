class PasswordResetMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_reset_mailer.send_password_reset.subject
  #
  def send_password_reset(params = {})
    @password = params[:password]
    mail to: params[:email], subject: "CB Cortex Password Reset"
  end
end
