class ButtonsCell < Cell::ViewModel
  def edit_button
    render
  end

  private

  def content_item
    model
  end

  def content_type
    content_item.content_type
  end
end
