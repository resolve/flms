module Flms
  class EmbedLayersController < AbstractLayerController

    def new
      @layer = EmbedLayer.new.build_default_keyframes
    end

    def create
      @layer = EmbedLayer.new params[:embed_layer]
      do_create
    end

    def update
      do_update @layer.update_attributes(params[:embed_layer])
    end

  protected

    def load_layer
      @layer = EmbedLayer.find params[:id]
    end

  end
end
