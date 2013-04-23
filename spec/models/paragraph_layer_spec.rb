require 'spec_helper'

describe Flms::ParagraphLayer do
  include NamedFactories

  describe 'view_object' do
    it 'provides a view object' do
      expect(subject.view_object).to be_a Flms::ParagraphLayerViewObject
    end
  end

  describe 'defaults' do
    it 'generates a default width' do
      expect(subject.width).to eql 0.2
    end
  end

  describe 'validation' do
    describe 'header' do
      it 'does not permit null header' do
        paragraph_layer_1a1.update_attribute(:header, nil)
        expect(paragraph_layer_1a1).to have(1).error_on(:header)
      end
    end

    describe 'body' do
      it 'does not permit null body' do
        paragraph_layer_1a1.update_attribute(:body, nil)
        expect(paragraph_layer_1a1).to have(1).error_on(:body)
      end
    end
  end

end
