require 'spec_helper'

describe Flms::AnimationLayer do
  include NamedFactories

  describe 'view_object' do
    it 'provides a view object' do
      expect(subject.view_object.is_a?(Flms::AnimationLayerViewObject)).to be_true
    end
  end

  describe 'image attachments' do
    let(:layer) { animation_layer_1a1 }

    it 'has an attachment' do
      expect(layer.image.path).to match 'placeholder.png'
    end
  end

  describe 'validations' do
    describe 'for frame_rate' do
      it 'does not allow negative frame rate' do
        animation_layer_1a1.update_attributes frame_rate: -1
        expect(animation_layer_1a1).to have(1).error_on(:frame_rate)
      end

      it 'does not allow frame rate of zero' do
        animation_layer_1a1.update_attributes frame_rate: 0
        expect(animation_layer_1a1).to have(1).error_on(:frame_rate)
      end
    end

    describe 'for frame_count' do
      it 'does not allow negative frame count' do
        animation_layer_1a1.update_attributes frame_count: -1
        expect(animation_layer_1a1).to have(1).error_on(:frame_count)
      end

      it 'does not allow frame count of zero' do
        animation_layer_1a1.update_attributes frame_count: 0
        expect(animation_layer_1a1).to have(1).error_on(:frame_count)
      end
    end
  end

end
