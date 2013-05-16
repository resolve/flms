require_dependency "flms/application_controller"

module Flms
  class BlocksController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!, except: [ :show ]
    before_filter :load_block, only: [:show, :edit, :update, :destroy]
    layout :resolve_layout

    def index
      @blocks = Block.all
    end

    def show
      respond_to do |format|
        format.plain_html { with_format('html') { render partial: 'flms/elements/block',
                                                         layout: 'flms/plain_styling',
                                                         locals: { block: @block, scroll_offset: 0 } } }
        format.html
        format.json { render json: @page }
      end
    end

    def new
      @block = Block.new
    end

    def edit
    end

    def create
      @block = Block.new(params[:block])

      if @block.save
        redirect_to blocks_path, notice: 'Block created.'
      else
        render action: "new"
      end
    end

    def update
      if @block.update_attributes(params[:block])
        redirect_to blocks_path, notice: 'Block was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @block.destroy
      redirect_to blocks_path, notice: 'Block deleted'
    end

  private

    def load_block
      @block = Block.find params[:id]
    end

    def resolve_layout
      action_name == 'show' ? 'flms/public' : 'flms/admin'
    end

  end
end
