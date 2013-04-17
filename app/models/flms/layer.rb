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
    validates :name, :'flms/css_name' => true
    validates_uniqueness_of :name, scope: :block_id

    scope :ordered_by_scroll_start, joins: [ :start_state_keyframe ], order: 'flms_keyframes.scroll_start'

    before_save :calculate_scroll_starts

    def view_object
      @view_object ||= Flms::LayerViewObject.new(self)
    end

    def build_default_keyframes
      self.start_state_keyframe ||= build_start_state_keyframe(layer: self)
      self.target_state_keyframe ||= build_target_state_keyframe(layer: self)
      self.end_state_keyframe ||= build_end_state_keyframe(layer: self)
      self
    end

    def keyframes
      [ start_state_keyframe, target_state_keyframe, end_state_keyframe ]
    end

    def scroll_start
      start_state_keyframe.scroll_start
    end

    def scroll_end
      start_state_keyframe.scroll_start +
          start_state_keyframe.scroll_duration +
          target_state_keyframe.scroll_duration +
          end_state_keyframe.scroll_duration
    end

    def calculate_scroll_starts
      target_state_keyframe.scroll_start = start_state_keyframe.scroll_start + start_state_keyframe.scroll_duration
      end_state_keyframe.scroll_start = target_state_keyframe.scroll_start + target_state_keyframe.scroll_duration
    end
  end
end
