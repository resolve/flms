module Flms
  class TextLayerViewObject < Flms::LayerViewObject

    def attributes(scroll_offset = 0)
      attributes = { id: @layer.name,
                     style: "font-size: #{ @layer.font_size }em; color: \##{ @layer.color }; " }
      attributes.merge keyframe_data_hash(scroll_offset)
    end

  end
end
