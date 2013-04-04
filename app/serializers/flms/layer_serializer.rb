module Flms
  class LayerSerializer < ActiveModel::Serializer
    attributes :type, :name
    has_many :keyframes, serializer: Flms::KeyframeSerializer

    def type
      'layer'
    end

    def keyframes
      object.keyframes
    end
  end
end
