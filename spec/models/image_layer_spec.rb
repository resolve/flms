require 'spec_helper'

describe Flms::ImageLayer do
  include NamedFactories

  describe 'view_object' do
    it 'provides a view object' do
      expect(Flms::ImageLayer.new.view_object.is_a?(Flms::ImageLayerViewObject)).to be_true
    end
  end

  describe 'image attachments' do
    let(:layer) { image_layer_1a1 }

    it 'has an attachment' do
      expect(layer.image.path).to_not be_nil
    end
  end
end
