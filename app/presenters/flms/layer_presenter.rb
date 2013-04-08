module Flms
  # encapsulates functionality around creation of HTML with the necessary skrollr ('data--...') attributes to properly
  # render a layer's content via it's keyframes.
  class LayerPresenter
    def initialize(layer)
      @layer = layer
    end

    def keyframe_data
      output = ''
      keyframe_data_hash.each { |k, v| output << "#{k}='#{v}' " }
      output.slice(0...-1)    # skip trailing whitespace
    end

    # Generate a hash of data to be provided to skrollr that describes the keyframe animation for this layer
    def keyframe_data_hash
      data = { }
      data['data-anchor-target'] = '#pagescroller'

      initial_pos = @layer.start_state_keyframe.scroll_start
      target_start_pos = @layer.target_state_keyframe.scroll_start
      target_end_pos = @layer.end_state_keyframe.scroll_start
      final_pos = @layer.end_state_keyframe.scroll_start + @layer.end_state_keyframe.scroll_duration

      start_presenter = Flms::KeyframePresenter.new(@layer.start_state_keyframe)
      target_presenter = Flms::KeyframePresenter.new(@layer.target_state_keyframe)
      end_presenter = Flms::KeyframePresenter.new(@layer.end_state_keyframe)

      data['data-0-top'] = 'display:none;'
      data["data-#{initial_pos}-top"] = 'display:block;' + start_presenter.styles
      data["data-#{target_start_pos}-top"] = target_presenter.styles
      data["data-#{target_end_pos}-top"] = target_presenter.styles
      data["data-#{final_pos}-top"] = 'display:none;' + end_presenter.styles

      data
    end
  end
end