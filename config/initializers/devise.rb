Devise.setup do |config|
  config.secret_key = 'b2cd4c7cfcd1025407ce50aebacf2df8653060db1b257a9199378d0327d33e6348d434111b6088d389fbb0eb621d2f15a33272ad02cf48ea6b7d8f20956743ef'
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.http_authenticatable = true
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128

  config.lock_strategy = :failed_attempts
  config.unlock_keys = [:email]
  config.unlock_strategy = :both
  config.maximum_attempts = 10
  config.unlock_in = 1.hour
  config.last_attempt_warning = true

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.warden do |manager|
    manager.failure_app = AuthenticationFailure
  end
end
