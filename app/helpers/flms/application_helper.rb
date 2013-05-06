module Flms
  module ApplicationHelper

    # Return 'active' if the current request is to the specified controller,
    # otherwise return an empty string.
    def nav_active_class controller_path
      params[:controller] == controller_path ? 'active' : ''
    end

  end
end
