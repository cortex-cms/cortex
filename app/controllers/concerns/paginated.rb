module Paginated
  extend ActiveSupport::Concern

  def page
    @page ||= params[:page].to_i || 1
  end

  def per_page
    @per_page ||= params[:per_page].to_i == 0 ? AppSettings.default_page_size : params[:per].to_i
  end

  def set_pagination_results(resource, results, total_count = nil)
    return unless results.count > 0

    # Calculate paging information
    count        = total_count || resource.count
    current_page = page
    total_pages  = (count / (per_page).to_i).to_i + 1
    page_start   = (current_page - 1) * per_page + 1
    page_end     = (current_page - 1) * per_page + results.count

    # Link header
    page         = {}
    page[:first] = 1 if total_pages > 1
    page[:last]  = total_pages if total_pages > 1
    page[:next]  = current_page + 1 unless (current_page == total_pages)
    page[:prev]  = current_page - 1 if (total_pages > 1 && current_page > 1)

    request_params       = request.query_parameters
    url_without_params   = request.original_url.slice(0..(request.original_url.index('?')-1)) unless request_params.empty?
    url_without_params ||= request.original_url

    # Create links for Link header
    pagination_links = []
    page.each do |k,v|
      new_request_hash= request_params.merge({:page => v})
      pagination_links << "<#{url_without_params}?#{new_request_hash.to_param}>;rel=\"#{k}\">"
    end

    # Set headers
    resource_name = resource.name.downcase.pluralize
    headers[:Links] = pagination_links.join(',')
    headers[:'Accept-Ranges'] = resource_name
    headers[:'Content-Range'] = "#{resource_name} #{page_start}-#{page_end}:#{per_page}/#{count}"

    # Chrome does not correctly lookup cached CORS preflight information for requests.
    # Specifically, when given a not modified (304) response it will not respect
    # headers previously exposed by Access-Control-Expose-Headers.
    headers[:'Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    headers[:Pragma]          = 'no-cache'
    headers[:Expires]         = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
