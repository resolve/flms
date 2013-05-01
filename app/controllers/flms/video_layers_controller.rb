module Flms
  class VideoLayersController < AbstractLayerController

    def new
      @layer = VideoLayer.new.build_default_keyframes
    end

    def create
      @layer = VideoLayer.new params[:video_layer]
      do_create
    end

    def update
      do_update @layer.update_attributes(params[:video_layer])
    end

  protected

    def load_layer
      @layer = VideoLayer.find params[:id]
    end

  end
end
