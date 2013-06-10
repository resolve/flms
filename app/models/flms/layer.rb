module Flms
  class Layer < ActiveRecord::Base
    attr_accessible :name, :type,
                    :width, :height, :z_index,
                    :width_percent, :height_percent,
                    :dom_remove, :active, :easing_function,
                    :start_state_keyframe_attributes, :target_state_keyframe_attributes, :end_state_keyframe_attributes

    belongs_to :block

    has_one :start_state_keyframe, dependent: :destroy
    has_one :target_state_keyframe, dependent: :destroy
    has_one :end_state_keyframe, dependent: :destroy
    accepts_nested_attributes_for :start_state_keyframe, :target_state_keyframe, :end_state_keyframe

    validates_presence_of :start_state_keyframe, :target_state_keyframe, :end_state_keyframe
    validates :name, :'flms/css_name' => true
    validates_uniqueness_of :name, scope: :block_id
    validates_numericality_of :width, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :height, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :z_index, allow_nil: false

    EASING_FUNCTIONS = %w(linear begin end quadratic cubic swing sqrt outCubic bounce)
    validates_inclusion_of :easing_function, in: EASING_FUNCTIONS

    scope :ordered_by_scroll_start, joins: [ :start_state_keyframe ], order: 'flms_keyframes.scroll_start'
    scope :is_active, conditions: { active: true }

    before_save :calculate_scroll_starts

    after_initialize :set_defaults

    IMAGE_DISPLAY_MODES = %w(contain cover)

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

	  def width_percent
      # It's ok for a layer to have an undefined width, so account for that here:
      self.width ? (self.width * 100).to_i : nil
    end

    def width_percent= val
      self.width = val.to_i / 100.0
    end

    def height_percent
      # It's ok for a layer to have an undefined height, so account for that here:
      self.height ? (self.height * 100).to_i : nil
    end

    def height_percent= val
      self.height = val.to_i / 100.0
    end

  protected

    # Set default values for this type of layer. Override this method in subclasses to customize.
    def set_defaults
      self.width ||= 0.20
      self.height ||= 0.20
    end

  private

    def must_be_css_hex_value
      self.errors[:color] << 'must be a valid CSS hex color code' unless color =~ /^([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
    end

  end
end