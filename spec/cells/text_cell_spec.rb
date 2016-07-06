require 'rails_helper'

RSpec.describe Cortex::FieldTypes::Core::Text::TextCell, type: :cell do

  context 'multiline input' do
    it 'should render a textarea tag' do
      field_item = double(name: "Name")
      model = double('model', field: field_item, data: "Multiline Input")
      form = ActionView::Helpers::FormBuilder.new("object", nil, nil, {})
      cols = 40
      rows = 40

      cell = cell('cortex/field_types/core/text/text', model, form: form, default_value: '', cols: cols, rows: rows).(:multiline_input)
      binding.pry
    end
  end

end
