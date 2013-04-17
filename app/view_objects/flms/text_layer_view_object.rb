module Flms
  class TextLayerViewObject < Flms::LayerViewObject

    def attributes(scroll_offset = 0)
      attributes = { id: @layer.name,
                     style: "color: \##{ @layer.color };" }
      attributes.merge! keyframe_data_hash(scroll_offset)
      keyframe_font_sizes(scroll_offset).each { |attr, style| attributes[attr] += style }
      attributes
    end

    # Generate font sizes based on scale factors in keyframe
    def keyframe_font_sizes(scroll_offset = 0)
      data = { }

      initial_pos = calculate_scroll_position(:initial, scroll_offset)
      target_start_pos = calculate_scroll_position(:target_start, scroll_offset)
      target_end_pos = calculate_scroll_position(:target_end, scroll_offset)
      final_pos = calculate_scroll_position(:final, scroll_offset)

      data["data-#{initial_pos}"] = " font-size: #{ @layer.font_size * @layer.start_state_keyframe.scale }em;"
      data["data-#{target_start_pos}"] = " font-size: #{ @layer.font_size * @layer.target_state_keyframe.scale }em;"
      data["data-#{target_end_pos}"] = " font-size: #{ @layer.font_size * @layer.target_state_keyframe.scale }em;"
      data["data-#{final_pos}"] = " font-size: #{ @layer.font_size * @layer.end_state_keyframe.scale }em;"

      data
    end

  end
end
