module Flms
  class Layer < ActiveRecord::Base
    attr_accessible :name, :type,
                    :start_state_keyframe_attributes, :target_state_keyframe_attributes, :end_state_keyframe_attributes

    belongs_to :block

    has_one :start_state_keyframe, dependent: :destroy
    has_one :target_state_keyframe, dependent: :destroy
    has_one :end_state_keyframe, dependent: :destroy
    accepts_nested_attributes_for :start_state_keyframe, :target_state_keyframe, :end_state_keyframe
    validates_presence_of :start_state_keyframe, :target_state_keyframe, :end_state_keyframe

    # TODO: calculate scroll_start attributes of target and end keyframes
    # before_save :calculate_scroll_starts

    def build_default_keyframes
      self.start_state_keyframe ||= build_start_state_keyframe(layer: self)
      self.target_state_keyframe ||= build_target_state_keyframe(layer: self)
      self.end_state_keyframe ||= build_end_state_keyframe(layer: self)
      self
    end

    def keyframes
      [ start_state_keyframe, target_state_keyframe, end_state_keyframe ]
    end
  end
end
