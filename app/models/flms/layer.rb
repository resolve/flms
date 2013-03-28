module Flms
  class Layer < ActiveRecord::Base
    attr_accessible :name, :type,
                    :start_state_keyframe_attributes, :target_state_keyframe_attributes, :end_state_keyframe_attributes

    belongs_to :block

    has_one :start_state_keyframe, class_name: 'Flms::StartStateKeyframe', dependent: :destroy
    has_one :target_state_keyframe, class_name: 'Flms::TargetStateKeyframe', dependent: :destroy
    has_one :end_state_keyframe, class_name: 'Flms::EndStateKeyframe', dependent: :destroy
    accepts_nested_attributes_for :start_state_keyframe, :target_state_keyframe, :end_state_keyframe
    validates_presence_of :start_state_keyframe, :target_state_keyframe, :end_state_keyframe

    def build_default_keyframes
      self.start_state_keyframe = build_start_state_keyframe(layer: self) unless start_state_keyframe
      self.target_state_keyframe = build_target_state_keyframe(layer: self) unless target_state_keyframe
      self.end_state_keyframe = build_end_state_keyframe(layer: self) unless end_state_keyframe
      self
    end
  end
end
