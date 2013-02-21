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
      @page = Page.new
    end

    def edit
      @page = Page.find_by_url params[:id]
    end

    def create
      @page = Page.new params[:page]
      if @page.save
        redirect_to pages_path, notice: 'Page was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      @page = Page.find_by_url params[:id]
      if @page.update_attributes params[:page]
        redirect_to pages_path, notice: 'Page was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @page = Page.find_by_url params[:id]
      @page.destroy
      redirect_to pages_url
    end
  end
end
