module Flms
  module ApplicationHelper

    # Return 'active' if the current request is to the specified controller,
    # otherwise return an empty string.
    def nav_active_class controller_path
      params[:controller] == controller_path ? 'active' : ''
    end

    # Get a background-image style for the specified block.
    # If the block doesn't have a thumbnail, return an empty string.
    def block_thumbnail_div_background_style block
      block.thumbnail? ? "background-image: url(#{ block.thumbnail.thumb.url })" : ''
    end

  end
end
