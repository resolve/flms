module Flms
  class TextLayersController < AbstractLayerController

    def new
      @layer = TextLayer.new.build_default_keyframes
    end

    def create
      @layer = TextLayer.new params[:text_layer]
      do_create
    end

    def update
      do_update @layer.update_attributes(params[:text_layer])
    end

  protected

    def load_layer
      @layer = TextLayer.find params[:id]
    end
  end
end

