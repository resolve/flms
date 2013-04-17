module Flms
  class ImageLayerViewObject < Flms::LayerViewObject

    def src
      @layer.image.url
    end

    def attributes(scroll_offset = 0)
      attributes = { id: @layer.name }
      attributes.merge keyframe_data_hash(scroll_offset)
    end

  end
end
