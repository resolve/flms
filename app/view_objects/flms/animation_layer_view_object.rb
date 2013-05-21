module Flms
  class AnimationLayerViewObject < Flms::LayerViewObject

    def src
      @layer.image.url
    end

    def attributes(scroll_offset = 0)
      attributes = { id: @layer.name }
      attributes.merge keyframe_data_hash(scroll_offset)
    end

    # Define attributes related to animating the sprited image
    def frames_attributes(scroll_offset = 0)
      data = { }
      (0...@layer.frame_count).each do |frame_index|
        y_offset = -(frame_index * frame_sprite_height)
        data["data-#{ frame_pixel_start(frame_index, scroll_offset) }"] = "background-position: 0 #{ y_offset }px;"
        data["data-#{ frame_pixel_end(frame_index, scroll_offset) }"] = "background-position: 0 #{ y_offset }px;"
      end
      data[:style] = "width: #{ @layer.image_width }px; height: #{ frame_sprite_height }px;" \
                     "background-image: url(#{ src }); background-size: #{ @layer.image_display_mode };"
      data
    end

    # Pixel start of specified frame (frame number is 0..n)
    def frame_pixel_start(frame, scroll_offset = 0)
      (scroll_offset + (frame * @layer.frame_rate)).to_i
    end

    # Pixel end of specified frame (frame number is 0..n)
    def frame_pixel_end(frame, scroll_offset = 0)
      (scroll_offset + ((frame + 1) * @layer.frame_rate) - 1).to_i
    end

    # Calculate the pixel size of a single frame of animation;
    # since animation sprites contain multiple frames stiched together
    # vertically, the pixel height will be the image height divided
    # by the number of frames contained within the sprite.
    def frame_sprite_height
      @layer.image_height / @layer.frame_count
    end

  end
end
