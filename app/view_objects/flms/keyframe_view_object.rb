module Flms

  # A keyframe presenter encapsulates translation of flms keyframe attributes to the CSS-friendly 'data--...'
  # attributes used by Skrollr.
  class KeyframeViewObject

    # Keyframe model attributes listed here will be included in the DOM:
    KEYFRAME_ATTRIBUTES = [ #:width, :height,
                            :position_x, :position_y,
                            :opacity, :scale, :blur ]

    # All attributes need a formatter function:
    KEYFRAME_ATTRIBUTE_FORMATTERS = { width: :format_as_percent,
                                      height: :format_as_percent,
                                      position_x: :format_as_percent,
                                      position_y: :format_as_percent,
                                      opacity: :format_as_decimal,
                                      scale: :format_as_transform,
                                      blur: :format_as_filter }

    # If a keyframe attribute on the model is not the same as it's corresponding CSS,
    # provide translations here:
    CSS_NAMES_FOR_KEYFRAME_ATTRIBUTES = { position_x: 'left',
                                          position_y: 'top' }

    def initialize(keyframe)
      @keyframe = keyframe
    end

    # Generate a string of CSS styling for each attribute provided by the keyframe
    def styles
      KEYFRAME_ATTRIBUTES.map { |attribute| style_for_attribute(attribute) }.join ' '
    end

    # Generate CSS style string for specified attribute.
    # Uses value of attribute in associated keyframe, unless override is specified,
    # in which case will generate style using overridden value.
    def style_for_attribute(attr, override = nil)
      value = override || @keyframe.send(attr)
      name = CSS_NAMES_FOR_KEYFRAME_ATTRIBUTES[attr] || attr.to_s
      formatter = KEYFRAME_ATTRIBUTE_FORMATTERS[attr]
      "#{ self.send(formatter, name, value) };"
    end

    #### Attribute formatters are below; formatters must accept an attribute name (string)
    #### and value parameter (number or string), and return a string.

    def format_as_decimal(name, value)
      "#{name}: #{value}"
    end
    
    def format_as_percent(name, value)
      "#{name}: #{value * 100}%"
    end

    def format_as_transform(name, value)
      "transform: #{name.to_s}(#{value})"
    end

    def format_as_filter(name, value)
      "filter: #{name.to_s}(#{value})"
    end

  end
end
