class IndexCell < Cell::ViewModel
  property :data

  def index
    render
  end

  def table_headers
    render
  end

  def table_body
    render
  end

  private

  def render_table_header(column_data)
    column_data[:name]
  end
end
