class TenantCell < Cell::ViewModel
  property :name
  property :icon

  def current
    render
  end
end
