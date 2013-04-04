require 'spec_helper'

describe Flms::Layer do
  include NamedFactories

  describe 'scopes' do
    describe 'ordered_by_scroll_start' do
      def builder pos
        create :layer, block: block_1a,
               start_state_keyframe_attributes: { scroll_start: pos },
               target_state_keyframe_attributes: {},
               end_state_keyframe_attributes: {}
      end

      let!(:layer_0) { builder(3) }
      let!(:layer_1) { builder(2) }
      let!(:layer_2) { builder(1) }

      it 'returns layers ordered by the scroll start of their start keyframe' do
        layers = block_1a.layers.ordered_by_scroll_start
        expect(layers[0]).to eql layer_2
        expect(layers[1]).to eql layer_1
        expect(layers[2]).to eql layer_0
      end
    end
  end

  describe 'keyframes' do
    describe 'build_default_keyframes' do
      it 'creates valid associations' do
        layer = Flms::Layer.new.build_default_keyframes
        expect(layer.start_state_keyframe.layer).to eql layer
        expect(layer.target_state_keyframe.layer).to eql layer
        expect(layer.end_state_keyframe.layer).to eql layer
      end

      it 'preserves the associations through save/reload' do
        layer = Flms::Layer.new.build_default_keyframes
        layer.save!
        layer.reload
        expect(layer.start_state_keyframe.layer).to eql layer
        expect(layer.target_state_keyframe.layer).to eql layer
        expect(layer.end_state_keyframe.layer).to eql layer
      end
    end

    describe 'validations' do
      describe 'for keyframes' do
        it 'requires all keyframes to be properly associated' do
          expect { Flms::Layer.create! }.to raise_error ActiveRecord::RecordInvalid
        end

        it 'passes validation when we correctly associate keyframes' do
          layer = Flms::Layer.new.build_default_keyframes
          expect { layer.save! }.not_to raise_error
        end
      end
    end

  end
end
