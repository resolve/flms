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

    # CSS positions; common name, then corresponding x and y positions
=begin
    DIRECTIONAL_STRINGS = %w[top-left top top-right right bottom-right bottom bottom-left left]
    DIRECTIONAL_POS = [[0, 0], [0.5, 0], [1, 0], [1, 0.5], [1, 1], [0.5, 1], [0, 1], [0, 0.5]]

    # return a string describing the x and y position for the keyframe
    # i.e., if x,y pos is (.5, .5), return 'right'
    def position_string
      raise 'cannot interpret x,y position' unless DIRECTIONAL_POS.include?([position_x, position_y])
      DIRECTIONAL_STRINGS[DIRECTIONAL_POS.index([position_x, position_y])]
    end
=end

  end
end
