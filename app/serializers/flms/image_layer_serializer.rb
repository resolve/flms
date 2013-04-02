module Flms
  class ImageLayerSerializer < LayerSerializer
    attributes :url, :type

    def type
      'image'
    end

    def url
      object.image.url
    end
  end
end
