module Flms
  class ParagraphLayer < Layer
    attr_accessible :header, :body

    validates :header, presence: true
    validates :body, presence: true

    def view_object
      @view_object ||= Flms::ParagraphLayerViewObject.new(self)
    end

    protected

    def set_default_values
      self.width ||= 0.20
    end

  end
end
