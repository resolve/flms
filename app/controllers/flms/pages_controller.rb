require_dependency "flms/application_controller"

module Flms
  class PagesController < ApplicationController
    before_filter :authenticate_user!, except: [ :show ]
    before_filter :load_page, except: [ :index, :new, :create ]
    layout :resolve_layout

    def index
      @pages = Page.all
    end

    def show
      respond_to do |format|
        format.plain_html { render partial: 'page', formats: [:html]  }
        format.html
        format.json { render json: @page }
      end
    end

    def new
      @page = Page.new
    end

    def edit
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
      if @page.update_attributes params[:page]
        redirect_to pages_path, notice: 'Page was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @page.destroy
      redirect_to pages_url
    end

    protected

    def load_page
      @page = Page.find_by_url(params[:id]) || raise(ActionController::RoutingError.new('Page Not Found'))
    end

    def resolve_layout
      action_name == 'show' ? 'flms/public' : 'flms/admin'
    end

  end
end
