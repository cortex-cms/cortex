module ApplicationHelper
  def title
    title = 'Cortex Administration'
    title += " | #{render_breadcrumbs}" if render_breadcrumbs
    title
  end

  def extra_config
    Cortex.config.extra
  end
end
