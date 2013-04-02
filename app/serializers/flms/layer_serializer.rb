module Flms
  class LayerSerializer < ActiveModel::Serializer
    attributes :type, :name
    has_many :keyframes, serializer: Flms::KeyframeSerializer

    def type
      'undefined'
    end

    def keyframes
      [ object.start_state_keyframe, object.target_state_keyframe, object.end_state_keyframe ]
    end
  end
end
