require_dependency "flms/application_controller"

module Flms
  class BlocksController < ApplicationController
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
      @block = Block.find(params[:id])
      if @block.update_attributes(params[:block])
        redirect_to @block, notice: 'Block was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @block = Block.find(params[:id])
      @block.destroy
      redirect_to blocks_url
    end
  end
end
