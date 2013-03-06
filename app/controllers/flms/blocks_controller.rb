require_dependency "flms/application_controller"

module Flms
  class BlocksController < ApplicationController
    before_filter :authenticate_user!
    layout 'flms/admin'

    def index
      @page = Flms::Page.find_by_url params[:page_id]
      @blocks = @page.blocks
    end

    def show
      @block = Block.find(params[:id])
    end

    def new
      @page = Page.find_by_url params[:page_id]
      @block = Block.new
    end

    def edit
      @page = Page.find_by_url params[:page_id]
      @block = Block.find(params[:id])
    end

    def create
      @page = Page.find_by_url params[:page_id]
      @block = Block.new(params[:block])
      if @block.save
        @block.pages << @page
        redirect_to page_blocks_path(@page), notice: 'Block created.'
      else
        render action: "new"
      end
    end

    def update
      @page = Page.find_by_url params[:page_id]
      @block = Block.find(params[:id])
      if @block.update_attributes(params[:block])
        redirect_to [@page, :blocks], notice: 'Block was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @page = Page.find_by_url params[:page_id]
      @block = Block.find params[:id]
      @block.destroy
      redirect_to page_blocks_path(@page), notice: 'Block deleted'
    end
  end
end
