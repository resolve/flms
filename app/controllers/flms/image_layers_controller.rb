module Flms
  class ImageLayersController < AbstractLayerController

    def new
      @layer = ImageLayer.new.build_default_keyframes
    end

    def create
      @layer = ImageLayer.new params[:image_layer]
      @layer.image = params[:image_layer][:image]
      do_create
    end

    def update
      do_update @layer.update_attributes(params[:image_layer])
    end

  protected

    def load_layer
      @layer = ImageLayer.find params[:id]
    end

  end
end

