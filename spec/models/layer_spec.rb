require 'spec_helper'

describe Flms::Layer do
  include NamedFactories

  describe 'scroll position autocalculation' do
    let(:layer) { build :layer }

    it 'correctly calculates scroll positions on save' do
      expect(layer.start_state_keyframe.scroll_start).to eql 0
      expect(layer.target_state_keyframe.scroll_start).to be_nil
      expect(layer.end_state_keyframe.scroll_start).to be_nil
      layer.save!
      expect(layer.start_state_keyframe.scroll_start).to eql 0
      expect(layer.target_state_keyframe.scroll_start).to eql 100
      expect(layer.end_state_keyframe.scroll_start).to eql 200
    end
  end

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

  describe 'view_object' do
    it 'provides a view object' do
      expect(Flms::Layer.new.view_object.is_a?(Flms::LayerViewObject)).to be_true
    end
  end

  describe 'build_default_keyframes' do
    let(:layer) { Flms::Layer.new(name: 'abc').build_default_keyframes }

    it 'creates valid associations' do
      expect(layer.start_state_keyframe.layer).to eql layer
      expect(layer.target_state_keyframe.layer).to eql layer
      expect(layer.end_state_keyframe.layer).to eql layer
    end

    it 'preserves the associations through save/reload' do
      layer.save!
      layer.reload
      expect(layer.start_state_keyframe.layer).to eql layer
      expect(layer.target_state_keyframe.layer).to eql layer
      expect(layer.end_state_keyframe.layer).to eql layer
    end
  end

  describe 'validations' do
    let(:layer) { Flms::Layer.new.build_default_keyframes }

    describe 'for name' do
      describe 'uniqueness' do
        it 'validates uniqueness on block' do
          layer_1a1
          layer_1a2
          layer_1a2.update_attributes name: layer_1a1.name
          expect(layer_1a2).to have(1).error_on(:name)
        end
      end
    end

    describe 'for keyframes' do
      it 'requires all keyframes to be properly associated' do
        expect { Flms::Layer.create! }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  describe 'keyframes' do
    let(:layer) { Flms::Layer.new.build_default_keyframes }

    it 'returns an array containing start, target, and end keyframes' do
      result = layer.keyframes
      expect(result[0]).to eql layer.start_state_keyframe
      expect(result[1]).to eql layer.target_state_keyframe
      expect(result[2]).to eql layer.end_state_keyframe
    end
  end

  describe 'scroll start and end' do
    let(:layer) { l = Flms::Layer.new.build_default_keyframes; l.start_state_keyframe.scroll_start = 1; l }

    describe 'scroll_start' do
      it 'returns scroll start of initial state' do
        expect(layer.scroll_start).to eql 1
      end
    end

    describe 'scroll_end' do
      it 'returns scroll start of initial state plus durations of target and end states' do
        expect(layer.scroll_end).to eql 301
      end
    end
  end

  describe 'translation accessors' do
    describe 'width_percent' do
      it 'sets width correctly' do
        expect(Flms::Layer.new(width_percent: 50).width).to eql 0.5
      end

      it 'gets width correctly' do
        expect(Flms::Layer.new(width: 0.5).width_percent).to eql 50
      end
    end

    describe 'height_percent' do
      it 'sets height correctly' do
        expect(Flms::Layer.new(height_percent: 50).height).to eql 0.5
      end

      it 'gets height correctly' do
        expect(Flms::Layer.new(height: 0.5).height_percent).to eql 50
      end
    end
  end

end
