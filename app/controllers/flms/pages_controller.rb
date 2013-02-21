require_dependency "flms/application_controller"

module Flms
  class PagesController < ApplicationController
    #load_and_authorize_resource class: 'Flms::Page', find_by: :url
    layout 'flms/admin'

    def index
      @pages = Page.all
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
      if @page.save
        redirect_to admin_pages_path, notice: 'Page was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      if @page.update_attributes params[:page]
        redirect_to admin_pages_path, notice: 'Page was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @page.destroy
      redirect_to admin_pages_url
    end
  end
end
