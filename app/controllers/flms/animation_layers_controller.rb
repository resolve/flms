module Flms
  class AnimationLayersController < AbstractLayerController

    def new
      @layer = AnimationLayer.new.build_default_keyframes
    end

    def create
      @layer = AnimationLayer.new params[:animation_layer]
      @layer.image = params[:animation_layer][:image]
      do_create
    end

    def update
      do_update @layer.update_attributes(params[:animation_layer])
    end

  protected

    def load_layer
      @layer = AnimationLayer.find params[:id]
    end

  end
end

