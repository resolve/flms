module Flms
  class ParagraphLayerViewObject < Flms::LayerViewObject

    def attributes(scroll_offset = 0)
      attributes = { id: @layer.name }
      attributes.merge! keyframe_data_hash(scroll_offset)
      attributes
    end

  protected

    def style_data_for_keyframes
      { width: @layer.width,
        free_height: true }
    end

  end
end
