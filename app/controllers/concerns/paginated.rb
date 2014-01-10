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

    resource_name = resource.name.downcase.pluralize
    headers[:'Accept-Ranges'] = resource_name
    headers[:'Content-Range'] = "#{resource_name} #{page_start}-#{page_end}:#{per_page}/#{count}"
  end
end