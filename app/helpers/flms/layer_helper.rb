module Flms
  module LayerHelper

    def view_partial_name(layer)
      layer.class.name.demodulize.underscore
    end

  end
end
