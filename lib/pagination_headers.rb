module PaginationHeaders

  def set_pagination_headers(scope, name)
    pagination = create_pagination(scope, name)
    pages = create_pages(pagination)
    links = create_links(pages, pagination)

    header 'Link', links.join(', ') unless links.empty?
    header 'Content-Range', '%{name} %{page_start}-%{page_end}:%{per_page}/%{total_items}' % pagination
    header 'X-Total-Items', pagination[:total_items].to_s
  end

  def create_pagination(scope, name)
    per_page         = scope.limit_value
    total_items      = scope.total_count
    page             = scope.current_page

    count            = scope.count
    pages            = total_items ? (total_items / per_page) + 1 : 0
    page_start       = (page - 1) * per_page
    page_end         = count > 0 ? (page_start + count) - 1 : 0
    name             = name

    # Params hash
    {
        :per_page    => per_page,
        :page        => page,
        :page_start  => page_start,
        :page_end    => page_end,
        :total_items => total_items,
        :pages       => pages,
        :count       => count,
        :name        => name
    }
  end

  private

  def create_links(pages, pagination)
    if pages.empty?
      return []
    end
    per_page = pagination[:per_page]
    url = url_without_params
    links = []
    pages.each do |key, value|
      new_params = query_params.merge({ :page => value, :per_page => per_page })
      links << "<#{url}?#{new_params.to_param}>; rel=\"#{key}\""
    end
    links
  end

  def create_pages(pagination)
    pages = {}
    pages[:first] = 1 if pagination[:pages] > 1 && pagination[:page] > 1
    pages[:prev] = pagination[:page] - 1 if pagination[:page] > 1
    pages[:next] = pagination[:page] + 1 if pagination[:page] < pagination[:pages]
    pages[:last] = pagination[:pages] if pagination[:pages] > 1 && pagination[:page] < pagination[:pages]
    pages
  end

  def url_without_params
    request.url.split('?').first
  end

  def query_params
    @query_params ||= parse_query_params
  end

  def parse_query_params
    params = {}
    CGI::parse(env['QUERY_STRING']).each{|k, v| params[k] = v[0] }
    params
  end
end