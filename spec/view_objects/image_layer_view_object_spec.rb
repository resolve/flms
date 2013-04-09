require 'spec_helper'

describe Flms::ImageLayerViewObject do
  let(:image_layer) { create :image_layer }
  let(:presenter) { Flms::ImageLayerViewObject.new(image_layer) }

  describe 'src' do
    it 'returns url of attached image' do
      expect(presenter.src).to eql '/uploads/flms/image_layer/image/1/placeholder.png'
    end
  end

  describe 'attributes' do
    it 'generates valid attributes' do
      expect(presenter.attributes).to match /data-\d*='.*'/
    end
  end

end
