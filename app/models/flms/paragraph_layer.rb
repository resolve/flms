module Flms
  class ParagraphLayer < Layer
    attr_accessible :header, :body, :color

    validates :header, presence: true
    validates :body, presence: true
    validate :color, :must_be_css_hex_value

    def view_object
      @view_object ||= Flms::ParagraphLayerViewObject.new(self)
    end

  protected

    def set_defaults
      self.width ||= 0.20
      self.color ||= 'fff'
    end

  end
end
