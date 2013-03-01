require_dependency "flms/application_controller"

module Flms
  class DashboardController < ApplicationController
    before_filter :authenticate_user!
    layout 'flms/admin'

    def index
      @pages = Page.all
    end
  end
end

