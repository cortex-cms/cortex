module ApplicationHelper
  def title
    title = 'Cortex Administration'
    title += " | #{render_breadcrumbs builder: TitleBuilder}" if render_breadcrumbs
    title
  end

  def extra_config
    Cortex.config.extra
  end

  def qualtrics_domain
  	extra_config.qualtrics_id.delete('_').downcase
  end

  def flag_enabled?(flag_name)
    Cortex.flipper[flag_name].enabled?(current_user, request)
  end
end
