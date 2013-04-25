module Flms

  # A keyframe presenter encapsulates translation of flms keyframe attributes to the CSS-friendly 'data--...'
  # attributes used by Skrollr.
  class KeyframeViewObject

    # All attributes need a formatter function:
    KEYFRAME_ATTRIBUTE_FORMATTERS = { width: :format_as_px,
                                      height: :format_as_px,
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
    # Available options are:
    #   :width        - default 0, affects width and margin-left of layer
    #   :height       - default 0, affects height and margin-top of layer
    #   :free_height  - if true, will suppress generation of height style
    # Will add margins using provided values, and pin the layer within the viewport
    # using width and height.
    def styles(options = {})
      options[:width] ||= 0
      options[:height] ||= 0
      options[:free_height] ||= false

      attribs = [ :position_x, :position_y,
                  :opacity,
                  :blur ].map { |attribute| style_for_attribute(attribute) }.join ' '
      attribs += pinning(options[:width],
                         options[:height],
                         options[:free_height])
      attribs
    end

    # Generate position styling so that the layer remains fully in the viewport.
    # (Pinned to top-left if positioned top-left, pinned center if centered, etc.)
    def pinning(width, height, free_height = false)
      width_style = "#{ style_for_attribute(:width, @keyframe.scale * width) }; "
      height_style = free_height ? '' : "#{ style_for_attribute(:height, @keyframe.scale * height) }; "
      margin_left_style = "margin-left: #{ (@keyframe.position_x * @keyframe.scale * -width) + @keyframe.margin_left }px; "
      margin_top_style = "margin-top: #{ (@keyframe.position_y * @keyframe.scale * -height) + @keyframe.margin_top }px;"
      "#{width_style}#{height_style}#{margin_left_style}#{margin_top_style}"
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

    def format_as_px(name, value)
      "#{name}: #{value}px"
    end

    def format_as_transform(name, value)
      "transform: #{name.to_s}(#{value})"
    end

    def format_as_filter(name, value)
      "filter: #{name.to_s}(#{value})"
    end

  end
end
