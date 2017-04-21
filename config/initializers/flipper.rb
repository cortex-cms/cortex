module Cortex
  def self.flipper
    @flipper ||= Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

Cortex::Application.config.middleware.use Flipper::Middleware::Memoizer, Cortex.flipper

Flipper.register(:internal) { |request| request.internal? }
Flipper.register(:authenticated) { |request| request.session[:current_user].present? && request.session[:current_user][:authenticated] }
Flipper.register(:cortex) { |request| request.host == 'admin.cbcortex.com' }
Flipper.register(:dev) { |request| request.host == 'dev.admin.cbcortex.com' || request.host == 'localhost' }
Flipper.register(:staging) { |request| request.host == 'stg.admin.cbcortex.com' }
