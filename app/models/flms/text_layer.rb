module Flms
  class TextLayer < Layer
    attr_accessible :text, :font_size, :color

    validates :text, presence: true
    validates_numericality_of :font_size, greater_than_or_equal_to: 0
    validate :color, :must_be_css_hex_value

    def view_object
      @view_object ||= Flms::TextLayerViewObject.new(self)
    end

    private

    def must_be_css_hex_value
      self.errors[:color] << 'must be a valid CSS hex color code' unless color =~ /^([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
    end

  end
end
