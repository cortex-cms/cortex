class FieldCell < Cell::ViewModel
  self.view_paths << 'lib'

  property :field
  property :data

  private

  def render_nested_label(data_property)
    @options[:form].label "data[#{data_property}]", field.name do
      yield + field.name
    end
  end

  def render_label
    @options[:form].label :data, field.name
  end

  def render_field_id
    @options[:form].hidden_field :field_id, value: field.id
  end
end
