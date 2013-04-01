module Flms
  class Keyframe < ActiveRecord::Base
    attr_accessible :layer,
                    :scroll_start, :scroll_duration,
                    :width, :height,
                    :position_x, :position_y,
                    :opacity, :scale, :blur,
                    :opacity_percent, :scale_percent, :blur_percent

    belongs_to :layer

    validates_numericality_of :scroll_start, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :scroll_duration, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :width, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :height, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :opacity, greater_than_or_equal_to: 0, less_than_or_equal_to: 1, allow_nil: true
    validates_numericality_of :scale, greater_than_or_equal_to: 0, allow_nil: true

    def opacity_percent
      (self.opacity * 100).to_i
    end

    def opacity_percent= val
      self.opacity = val.to_i / 100.0
    end

    def scale_percent
      (self.scale * 100).to_i
    end

    def scale_percent= val
      self.scale = val.to_i / 100.0
    end

    def blur_percent
      (self.blur * 100).to_i
    end

    def blur_percent= val
      self.blur = val.to_i / 100.0
    end

  end
end
