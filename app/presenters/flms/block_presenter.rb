module Flms
  class BlockPresenter
    def initialize(block)
      @block = block
    end

    def to_html
      output = ''
      @block.layers.ordered_by_scroll_start.each { |layer| output << get_presenter_for(layer).to_html << "<br/>" }
      output
    end

    def get_presenter_for(layer)
      case layer.type
        when "Flms::ImageLayer"
          Flms::ImageLayerPresenter.new(layer)
        else
          raise 'unknown layer type'
      end
    end
  end
end