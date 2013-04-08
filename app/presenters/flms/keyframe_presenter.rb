module Flms
  # A keyframe presenter encapsulates translation of flms keyframe attributes to the CSS-friendly 'data--...' attributes
  # used by Skrollr.
  class KeyframePresenter
    # List of all attributes stored within keyframe:
    KEYFRAME_ATTRIBUTES = [:width, :height,
                           :position_x, :position_y,
                           :opacity, :scale, :blur]

    # If a keyframe attribute is not the same as it's corresponding CSS,
    # provide translations here:
    KEYFRAME_ATTRIBUTE_NAMES_TO_CSS = { position_x: 'left', position_y: 'top' }

    def initialize(keyframe)
      @keyframe = keyframe
    end

    # Generate a string of CSS styling for each attribute provided by the keyframe
    def styles
      styles = ""
      KEYFRAME_ATTRIBUTES.each { |attribute| styles << style_for_attribute(attribute) }
      styles
    end

    # Generate CSS style string for specified attribute.
    # Uses value of attribute in associated keyframe, unless override is specified,
    # in which case will generate style using overridden value.
    def style_for_attribute(attr, override = nil)
      value = override
      value ||= @keyframe.send(attr)
      name = KEYFRAME_ATTRIBUTE_NAMES_TO_CSS[attr] || attr.to_s
      "#{name}:#{float_value_to_percent_string(value)};"
    end

    def float_value_to_percent_string(value)
      "#{value * 100}%"
    end

  end
end