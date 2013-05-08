module Flms
  class ImageLayerViewObject < Flms::LayerViewObject

    def src
      @layer.image.url
    end

    def inner_attributes
      { style: """
          background-image: url(#{src});
          background-size: #{@layer.image_display_mode};
        """ }
    end

    def attributes(scroll_offset = 0)
      attributes = keyframe_data_hash(scroll_offset)
      attributes[:id] = @layer.name
      attributes
    end

  end
end
