module Flms
  class ImageLayerViewObject < Flms::LayerViewObject

    def src
      @layer.image.url
    end

    def attributes
      keyframe_data_hash
    end

  end
end
