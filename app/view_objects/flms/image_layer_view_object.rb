module Flms
  class ImageLayerViewObject < Flms::LayerViewObject

    def src
      @layer.image.url
    end

    def attributes(scroll_offset = 0)
      keyframe_data_hash(scroll_offset)
    end

  end
end
