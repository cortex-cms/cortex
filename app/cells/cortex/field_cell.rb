module Cortex
  class FieldCell < Cortex::ApplicationCell
    property :id
    property :data
    property :field
    property :content_item
    property :created_at
    property :updated_at
    property :deleted_at

    def association
      raise 'association renderer not implemented'
    end

    private

    def render_nested_label(data_property)
      @options[:form].label "data[#{data_property}]", field.name do
        yield + field.name
      end
    end

    def render_label
      @options[:form].label :data, field.name
    end

    def render_tooltip
      cell(::Plugins::Core::TooltipCell, nil, tooltip: @options[:tooltip], id: SecureRandom.base64(4))
    end

    def render_field_id
      @options[:form].hidden_field :field_id, value: field.id
    end
  end
end
