require_dependency "flms/application_controller"

module Flms
  class BlocksController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!
    before_filter :load_block, only: [:show, :edit, :update, :destroy]

    def index
      @blocks = Block.all
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
  end
end
