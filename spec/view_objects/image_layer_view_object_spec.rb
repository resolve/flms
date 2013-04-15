require 'spec_helper'

describe Flms::ImageLayerViewObject do
  let(:image_layer) { create :image_layer }
  let(:view_object) { Flms::ImageLayerViewObject.new(image_layer) }

  describe 'src' do
    it 'returns url of attached image' do
      expect(view_object.src).to eql '/uploads/flms/image_layer/image/1/placeholder.png'
    end
  end

end
