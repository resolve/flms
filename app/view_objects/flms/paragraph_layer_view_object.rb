module Flms
  class ParagraphLayerViewObject < Flms::LayerViewObject

    def attributes(scroll_offset = 0)
      attributes = keyframe_data_hash(scroll_offset)
      attributes[:id] = @layer.name
      attributes[:style] += "color: \##{ @layer.color };"
      attributes
    end

  protected

    def style_data_for_keyframes
      { width: @layer.width,
        free_height: true }
    end

  end
end
