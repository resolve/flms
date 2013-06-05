module Flms
  class EmbedLayerViewObject < Flms::LayerViewObject

    def embed_code
      @layer.embed_code
    end

    def attributes(scroll_offset = 0)
      attributes = keyframe_data_hash(scroll_offset)
      attributes[:id] = @layer.name
      attributes
    end

  end
end
