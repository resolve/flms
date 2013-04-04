require_dependency "flms/application_controller"

module Flms
  class BlocksController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!
    before_filter :load_page
    before_filter :load_block, only: [:show, :edit, :update, :destroy]

    def index
    end

    def show
    end

    def new
      @block = Block.new
    end

    def edit
    end

    def create
      @block = Block.new(params[:block])

      if @block.save
        @block.pages << @page
        redirect_to page_blocks_path(@page), notice: 'Block created.'
      else
        render action: "new"
      end
    end

    def update
      if @block.update_attributes(params[:block])
        redirect_to [@page, :blocks], notice: 'Block was successfully updated.'
      else
        render action: "edit"
      end
    end

    def update_all
      params[:block_data].each_with_index do |block_data, pos|
        position = @page.position_for_block block_data[:id].to_i
        position.active = block_data[:active]
        position.ordering = pos
        position.save!
      end
      render text: ''
    end

    def destroy
      @block.destroy
      redirect_to page_blocks_path(@page), notice: 'Block deleted'
    end


    private

    def load_page
      @page = Page.find_by_url params[:page_id]
    end

    def load_block
      @block = Block.find params[:id]
    end
  end
end
