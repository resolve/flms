require 'spec_helper'

describe Flms::KeyframePresenter do
  let!(:presenter) { Flms::KeyframePresenter.new(create :test_keyframe) }

  describe 'styles' do
    it 'generates correct style attributes' do
      styles = presenter.styles
      expect(styles).to eql 'width:30.0%;height:40.0%;left:50.0%;top:60.0%;opacity:70.0%;scale:80.0%;blur:90.0%;'
    end
  end

  describe 'style for attribute' do
    it 'generates correct style for keyframe attributes' do
      expect(presenter.style_for_attribute(:width)).to eql 'width:30.0%;'
    end

    describe 'translation using KEYFRAME_ATTRIBUTE_NAMES_TO_CSS' do
      it 'translates :position_x to \'left\'' do
        expect(presenter.style_for_attribute(:position_x)).to eql 'left:50.0%;'
      end

      it 'translates :position_y to \'top\'' do
        expect(presenter.style_for_attribute(:position_y)).to eql 'top:60.0%;'
      end
    end

    it 'raises an error if an invalid attribute is specified' do
      expect { presenter.style_for_attribute(:a_bad_attribute) }.to raise_error
    end

    it 'generates correct style when attribute value is overridden' do
      expect(presenter.style_for_attribute(:width, -0.123)).to eql 'width:-12.3%;'
    end
  end

  describe 'float_value_to_percent_string' do
    it 'converts correctly' do
      expect(presenter.float_value_to_percent_string(-0.123)).to eql '-12.3%'
    end

    it 'handles arbitrary number of decimal places' do
      expect(presenter.float_value_to_percent_string(0.1)).to eql '10.0%'
      expect(presenter.float_value_to_percent_string(-0.123456)).to eql '-12.3456%'
    end
  end
end

