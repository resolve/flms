module Flms
  class ParagraphLayersController < AbstractLayerController

    def new
      @layer = ParagraphLayer.new.build_default_keyframes
    end

    def create
      @layer = ParagraphLayer.new params[:paragraph_layer]
      do_create
    end

    def update
      do_update @layer.update_attributes(params[:paragraph_layer])
    end

  protected

    def load_layer
      @layer = ParagraphLayer.find params[:id]
    end
  end
end

