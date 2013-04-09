module Flms
  class ImageLayerViewObject < Flms::LayerViewObject

    def src
      @layer.image.url
    end

    def attributes
      render_keyframe_data_attributes(keyframe_data_hash)
    end

  end
end