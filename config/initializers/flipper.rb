require 'flipper/middleware/memoizer'

Flipper.configure do |config|
  config.default do
    adapter = Flipper::Adapters::ActiveRecord.new
    Flipper.new(adapter)
  end
end

Cortex::Engine.config.middleware.use Flipper::Middleware::Memoizer

Flipper.register(:internal) { |request| request.internal? }
Flipper.register(:authenticated) { |request| request.session[:current_user].present? && request.session[:current_user][:authenticated] }
Flipper.register(:cortex) { |request| request.host == 'admin.cbcortex.com' }
Flipper.register(:dev) { |request| request.host == 'dev.admin.cbcortex.com' || request.host == 'localhost' }
Flipper.register(:staging) { |request| request.host == 'stg.admin.cbcortex.com' }
