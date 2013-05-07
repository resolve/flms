module Flms
  class ApplicationController < ActionController::Base

    # When we want to render a partial as HTML, but specify the plain_html custom
    # format to a view, we need this method to swap the format to html so that
    # Rails can properly resolve the partials (since we use *.html.haml for both
    # :html and :plain_html formats)
    def with_format format
      old_formats = formats
      self.formats = [format]
      yield
      self.formats = old_formats
      nil
    end

  end
end
