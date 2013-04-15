require 'spec_helper'

describe Flms::TextLayer do
  include NamedFactories

  describe 'view_object' do
    it 'provides a view object' do
      expect(Flms::TextLayer.new.view_object.is_a?(Flms::TextLayerViewObject)).to be_true
    end
  end

  describe 'validation' do
    describe 'color' do
      it 'permits 3-digit hex color' do
        text_layer_1a1.update_attribute(:color, '1bc')
        expect(text_layer_1a1.color).to eql '1bc'
      end

      it 'permits 6-digit hex color' do
        text_layer_1a1.update_attribute(:color, 'abcdef')
        expect(text_layer_1a1.color).to eql 'abcdef'
      end

      it 'does not permit non-hex color' do
        text_layer_1a1.update_attribute(:color, 'abadcolorvalue')
        expect(text_layer_1a1).to have(1).error_on(:color)
      end
    end

    describe 'text' do
      it 'does not permit null text' do
        text_layer_1a1.update_attribute(:text, nil)
        expect(text_layer_1a1).to have(1).error_on(:text)
      end
    end

    describe 'font_size' do
      it 'does not permit negative size' do
        text_layer_1a1.update_attribute(:font_size, -1.0)
        expect(text_layer_1a1).to have(1).error_on(:font_size)
      end

      it 'does not permit null size' do
        text_layer_1a1.update_attribute(:font_size, nil)
        expect(text_layer_1a1).to have(1).error_on(:font_size)
      end
    end
  end

end
