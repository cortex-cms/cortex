class FieldCell < Cell::ViewModel
  self.view_paths << 'lib'

  property :field
  property :data

  private

  def render_label # Where does this common logic go?
    @options[:form].label :data, field.name
  end

  def render_field_id # Where does this common logic go?
    @options[:form].hidden_field :field_id, value: field.id
  end
end
