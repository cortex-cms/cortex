class TitleBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @elements.collect do |element|
      render_element(element)
    end.join(' > ')
  end

  def render_element(element)
    content = compute_name(element)
    ERB::Util.h(content)
  end
end
