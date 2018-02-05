require_dependency 'cortex/application_controller'

module Cortex
  class AdminController < ApplicationController
    before_action :authenticate_user!
  end
end
