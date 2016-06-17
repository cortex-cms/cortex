class DashboardsController < AdminController
  add_breadcrumb 'Dashboard', :dashboards_path

  def index
    redirect_to legacy_root_path if session[:legacy]
  end
end
