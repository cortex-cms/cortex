require_dependency 'cortex/application_controller'

module Cortex
  class DashboardsController < AdminController
    add_breadcrumb 'Dashboard', :dashboards_path
  end
end
