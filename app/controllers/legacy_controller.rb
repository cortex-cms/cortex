class LegacyController < ApplicationController
  before_action :authenticate_user!, :add_gon

  def index
    render layout: 'legacy_application'
  end

  private

  def add_gon
    gon.push({
               current_user: current_user.as_json,
               settings: {
                 cortex_base_url: "#{root_url}api/v1",
                 paging: {
                   defaultPerPage: 10
                 }
               }
             })
  end
end
