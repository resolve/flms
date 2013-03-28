module Flms
  class EndStateKeyframe < Keyframe
    after_initialize :set_default_values

    def set_default_values
      self.scroll_start ||= nil
      self.scroll_duration ||= 100
      self.width ||= 1.0
      self.height ||= 1.0
      self.position_x ||= 0.5
      self.position_y ||= 0.5
      self.opacity ||= 0.0
      self.scale ||= 1.0
      self.blur ||= 0.0
    end
  end
end
