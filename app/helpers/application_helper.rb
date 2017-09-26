module ApplicationHelper
  def title
    title = 'Cortex Administration'
    title += " | #{render_breadcrumbs builder: TitleBuilder}" if render_breadcrumbs
    title
  end

  def extra_config
    Cortex.config.extra
  end

  def user_session_props
    {
      environment: environment,
      tenant: (Tenant.find_by_name('Corporate') || current_user.tenant),
      current_user: current_user,
      tenants: Tenant.all,
      csrf_token: form_authenticity_token,
      sidebarExpanded: (current_page? root_path),
      environment_abbreviated: environment_abbreviated
    }
  end

  def wizard_props
    if @wizard
      @wizard.data.merge({
        content_type: @content_type,
        content_item: @content_item,
        fields: @content_type.fields
      })
    else
      {}
    end
  end

  def index_props
    @index || {}
  end

  def cortex_props
    user_session_props.merge({
      wizard: wizard_props,
      index: index_props
    })
  end

  def qualtrics_domain
    extra_config.qualtrics_id.delete('_').downcase
  end

  def flag_enabled?(flag_name)
    Cortex.flipper[flag_name].enabled?(current_user, request)
  end

  def environment
    request.local? ? :local : Rails.env
  end

  def environment_abbreviated
    case environment
      when 'production'
        :prd
      when 'staging'
        :stg
      when 'development'
        :dev
      else
        :loc
    end
  end
end
