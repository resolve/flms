module Flms

  # Create DOM for this layer, including all the necessary 'data-*' attributes to
  # animate it as desired  via skrollr.
  class LayerViewObject

    def initialize(layer)
      @layer = layer
    end

    def view_partial_name
      "flms/elements/#{ @layer.class.name.demodulize.underscore }"
    end

    def self.link_path_for(block, layer)
      link_path = Flms::Engine.routes.url_helpers.edit_block_image_layer_path(block, layer) if layer.is_a? Flms::ImageLayer
      link_path = Flms::Engine.routes.url_helpers.edit_block_text_layer_path(block, layer) if layer.is_a? Flms::TextLayer
      link_path = Flms::Engine.routes.url_helpers.edit_block_paragraph_layer_path(block, layer) if layer.is_a? Flms::ParagraphLayer
      link_path = Flms::Engine.routes.url_helpers.edit_block_embed_layer_path(block, layer) if layer.is_a? Flms::EmbedLayer
      link_path = Flms::Engine.routes.url_helpers.edit_block_animation_layer_path(block, layer) if layer.is_a? Flms::AnimationLayer
      link_path
    end

    # Generate a hash of data to be provided to skrollr that describes the keyframe animation for this layer
    def keyframe_data_hash(scroll_offset = 0)
      data = { }
      data['data-anchor-target'] = '#skrollr-body'
      data[:style] = "z-index: #{ @layer.z_index };"

      initial_pos = calculate_scroll_position(:initial, scroll_offset)
      target_start_pos = calculate_scroll_position(:target_start, scroll_offset)
      target_end_pos = calculate_scroll_position(:target_end, scroll_offset)
      final_pos = calculate_scroll_position(:final, scroll_offset)

      start_view_object = Flms::KeyframeViewObject.new(@layer.start_state_keyframe)
      target_view_object = Flms::KeyframeViewObject.new(@layer.target_state_keyframe)
      end_view_object = Flms::KeyframeViewObject.new(@layer.end_state_keyframe)

      data['data-0'] = 'display:none;'
      data["data-#{initial_pos}"] = 'display:block; ' + start_view_object.styles(style_data_for_keyframes)
      data["data-#{target_start_pos}"] = target_view_object.styles(style_data_for_keyframes)
      data["data-#{target_end_pos}"] = target_view_object.styles(style_data_for_keyframes)
      data["data-#{final_pos}"] = end_view_object.styles(style_data_for_keyframes)
      data["data-#{final_pos + 1}"] = 'display:none;' if @layer.dom_remove

      data
    end

    protected

    def calculate_scroll_position(state, offset)
      case state
        when :initial
          @layer.start_state_keyframe.scroll_start + offset
        when :target_start
          @layer.target_state_keyframe.scroll_start + offset
        when :target_end
          @layer.end_state_keyframe.scroll_start + offset
        when :final
          @layer.end_state_keyframe.scroll_start + @layer.end_state_keyframe.scroll_duration + offset
        else
          raise 'unknown state!'
      end
    end

    def style_data_for_keyframes
      { width: @layer.width,
        height: @layer.height }
    end

  end
end
