require_dependency "flms/application_controller"

module Flms
  class LayersController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!
    before_filter :load_page
    before_filter :load_block
    before_filter :load_layer, only: [:show, :edit, :update, :destroy]

    def destroy
      @layer.destroy
      redirect_to page_blocks_path(@page, @block), notice: 'Layer deleted'
    end


    private

    def load_page
      @page = Page.find_by_url params[:page_id]
    end

    def load_block
      @block = Block.find params[:block_id]
    end

    def load_layer
      @layer = Layer.find params[:id]
    end
  end
end

