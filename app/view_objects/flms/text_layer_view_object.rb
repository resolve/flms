module Flms
  class TextLayerViewObject < Flms::LayerViewObject

    def attributes(scroll_offset = 0)
      attributes = keyframe_data_hash(scroll_offset)
      attributes['style'] = "font-size: #{ @layer.font_size }em; " \
                            "color: \##{ @layer.color }; "
      attributes
    end

  end
end
