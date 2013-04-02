module Flms
  class KeyframeSerializer < ActiveModel::Serializer
    attributes :scroll_start, :scroll_duration,
               :width, :height,
               :position_x, :position_y,
               :opacity, :scale, :blur
  end
end
