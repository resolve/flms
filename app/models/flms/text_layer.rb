module Flms
  class TextLayer < Layer
    attr_accessible :text, :font_size, :color

    validates :text, presence: true
    validates_numericality_of :font_size, greater_than_or_equal_to: 0
    validate :color, :must_be_css_hex_value

    def view_object
      @view_object ||= Flms::TextLayerViewObject.new(self)
    end

  protected

    def set_defaults
      self.color ||= 'fff'
    end

  end
end
