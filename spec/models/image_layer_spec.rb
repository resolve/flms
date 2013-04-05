require 'spec_helper'

describe Flms::ImageLayer do
  include NamedFactories

  describe 'image attachments' do
    let(:layer) { image_layer_1a1 }

    it 'has an attachment' do
      expect(layer.image.path).to_not be_nil
    end
  end
end
