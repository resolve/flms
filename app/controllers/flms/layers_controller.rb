require_dependency "flms/application_controller"

module Flms
  class LayersController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!
    before_filter :load_block
    before_filter :load_layer, only: [:show, :update, :destroy]

    def destroy
      @layer.destroy
      redirect_to edit_block_path(@block), notice: 'Layer deleted'
    end

  private

    def load_block
      @block = Block.find params[:block_id]
    end

    def load_layer
      @layer = Layer.find params[:id]
    end
  end
end
