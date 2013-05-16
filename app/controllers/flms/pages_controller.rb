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
        format.plain_html { with_format('html') { render partial: 'flms/elements/page', formats: [:html],
                                                         layout: 'flms/plain_styling',
                                                         locals: { page: @page } } }
        format.html
        format.json { render json: @page }
      end
    end

    def new
      @page = Page.new
    end

    def edit
      @available_blocks = Block.all - @page.blocks
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

    def add_block
      @block = Block.find params[:block][:id]
      @page.blocks << @block
      redirect_to edit_page_path(@page), notice: 'Block added.'
    end

    def remove_block
      @block = Block.find params[:block_id]
      @page.blocks.delete @block
      redirect_to edit_page_path(@page), notice: 'Block removed.'
    end

    def update_blocks
      params[:block_data].each_with_index do |block_data, pos|
        position = @page.position_for_block block_data[:id].to_i
        position.active = block_data[:active]
        position.ordering = pos
        position.save!
      end
      render text: ''
    end

  protected

    def load_page
      @page = Page.find_by_url(params[:id]) || Page.find_by_url(params[:page_id]) || raise(ActionController::RoutingError.new('Page Not Found'))
    end

    def resolve_layout
      action_name == 'show' ? 'flms/public' : 'flms/admin'
    end

  end
end
