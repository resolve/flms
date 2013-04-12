require 'spec_helper'

describe Flms::LayerViewObject do

  describe 'view_partial_name' do
    let(:layer_view_object) { Flms::LayerViewObject.new(create :layer) }
    let(:layer_view_object_with_image_layer) { Flms::LayerViewObject.new(create :image_layer) }

    it 'should return \'layer\' for a Layer' do
      expect(layer_view_object.view_partial_name).to eql 'layer'
    end
    
    it 'should return \'image_layer\' for an ImageLayer' do
      expect(layer_view_object_with_image_layer.view_partial_name).to eql 'image_layer'
    end
  end
  
  describe 'keyframe_data_hash' do
    let(:view_object) { Flms::LayerViewObject.new(create :layer) }
    let(:data) { view_object.keyframe_data_hash(1) }

    it 'anchors to correct target' do
      expect(data['data-anchor-target']).to eql '#pagescroller'
    end

    it 'generates scroll positions correctly and includes scroll offset' do
      expect(data).to have_key 'data-1'
      expect(data).to have_key 'data-101'
      expect(data).to have_key 'data-201'
      expect(data).to have_key 'data-301'
    end
  end
end
