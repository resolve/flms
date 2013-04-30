module Flms
  class VideoLayer < Layer
    attr_accessible :embed_code

    validates :embed_code, presence: true

    def view_object
      @view_object ||= Flms::VideoLayerViewObject.new(self)
    end

  end
end
