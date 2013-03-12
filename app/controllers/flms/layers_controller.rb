require_dependency "flms/application_controller"

module Flms
  class LayersController < ApplicationController
    layout 'flms/admin'
    before_filter :authenticate_user!
    before_filter :load_page
    before_filter :load_block
    before_filter :load_layer, only: [:show, :edit, :update, :delete]

    def index
    end

    def show
    end

    def new
      @layer = Layer.new
    end

    def edit
    end

    def create
      @layer = Layer.new params[:layer]
      @layer.block = @block
      if @layer.save
        redirect_to page_block_path(@page, @block), notice: 'Layer created.'
      else
        render action: "new"
      end
    end

    def update
      if @layer.update_attributes(params[:layer])
        redirect_to [@page, :layers], notice: 'Layer was successfully updated.'
      else
        render action: "edit"
      end
    end

    def update_all
      params[:layer_data].each_with_index do |layer_data, pos|
        position = @page.position_for_layer layer_data[:id].to_i
        position.active = layer_data[:active]
        position.ordering = pos
        position.save!
      end
      render text: ''
    end

    def destroy
      @layer.destroy
      redirect_to page_layers_path(@page), notice: 'Layer deleted'
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

