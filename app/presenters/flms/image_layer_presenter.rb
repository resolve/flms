module Flms
  class ImageLayerPresenter < Flms::LayerPresenter

    def to_html
      tag = '<img '
      tag << 'src=\'' + @layer.image.url + '\''
      tag << ' ' + keyframe_data
      tag << '\>'
    end

  end
end