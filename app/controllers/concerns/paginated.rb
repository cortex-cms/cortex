module Paginated
  extend ActiveSupport::Concern

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per] || AppSettings.default_page_size
  end

  def set_pagination_results(resource, results, per_page)
    return unless results.count > 0

    count = results.count
    current_page = results.current_page
    total_pages = results.total_pages

    page_start = (current_page - 1) * per_page + 1
    page_end = (current_page - 1) * per_page + count

    page = {}
    page[:first] = 1 if total_pages > 1
    page[:last] = results.num_pages if total_pages > 1
    page[:next] = current_page + 1 unless results.last_page?
    page[:prev] = current_page - 1 if (total_pages > 1 && current_page > 1)

    request_params = request.query_parameters
    url_without_params = request.original_url.slice(0..(request.original_url.index('?')-1)) unless request_params.empty?
    url_without_params ||= request.original_url

    pagination_links = []
    page.each do |k,v|
      new_request_hash= request_params.merge({:page => v})
      pagination_links << "<#{url_without_params}?#{new_request_hash.to_param}>;rel=\"#{k}\">"
    end

    resource_name = resource.name.downcase.pluralize
    headers[:Links] = pagination_links.join(',')
    headers[:'Accept-Ranges'] = resource_name
    headers[:'Content-Range'] = "#{resource_name} #{page_start}-#{page_end}:#{per_page}/#{count}"
  end
end