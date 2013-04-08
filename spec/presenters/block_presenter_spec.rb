require 'spec_helper'

describe Flms::BlockPresenter do
  include NamedFactories

  describe 'get_presenter_for' do
    let(:layer) { Flms::Layer.new }
    let(:image_layer) { Flms::ImageLayer.new }
    let(:block) { Flms::Block.new }
    let(:subject) { Flms::BlockPresenter.new(block) }

    it 'should raise an error when the layer type is unknown' do
      expect { subject.get_presenter_for(layer) }.to raise_error
    end

    it 'should provide a image layer presenter for an image layer' do
      expect(subject.get_presenter_for(image_layer).class.name).to eql 'Flms::ImageLayerPresenter'
    end
  end

  describe 'to_html' do
    it 'calls to_html on all included layers' do
      image_layer_1a1
      image_layer_1a2
      output = Flms::BlockPresenter.new(block_1a).to_html
      expect(output.scan('<img').length).to eql 2
    end
  end

end
