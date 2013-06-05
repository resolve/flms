module Flms
  class EmbedLayer < Layer
    attr_accessible :embed_code

    validates :embed_code, presence: true

    def view_object
      @view_object ||= Flms::EmbedLayerViewObject.new(self)
    end

  end
end
