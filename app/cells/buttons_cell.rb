class ButtonsCell < Cell::ViewModel
  def publish_state_buttons
    render
  end

  def edit_button
    render
  end

  private

  def render_edit
    link_to "<i class='material-icons'>create</i>".html_safe, edit_content_type_content_item_path(content_type.id, content_item.id), class: 'mdl-button mdl-js-button mdl-button--icon'
  end

  def content_item
    @model
  end

  def content_type
    content_item.content_type
  end
end
