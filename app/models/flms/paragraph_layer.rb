module Flms
  class ParagraphLayer < Layer
    attr_accessible :header, :body

    validates :header, presence: true
    validates :body, presence: true

    after_initialize :init_width

    def view_object
      @view_object ||= Flms::ParagraphLayerViewObject.new(self)
    end

    protected

    def init_width
      self.width ||= 300.0
    end

  end
end
