require 'spec_helper'

describe Flms::LayerHelper do
  describe 'view_partial_name' do
    it 'should return \'layer\' for a Layer' do
      expect(helper.view_partial_name(Flms::Layer.new)).to eql 'layer'
    end

    it 'should return \'image_layer\' for an ImageLayer' do
      expect(helper.view_partial_name(Flms::ImageLayer.new)).to eql 'image_layer'
    end
  end
end

